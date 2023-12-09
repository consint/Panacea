/*
Panacea is an autopan audio effect plugin with the possibility of humanization.

Creator: Consistent Interruption
License: GPLv3

Created with Cabbage (https://github.com/rorywalsh/cabbage) and CSound (https://csound.com/). 
I wrote the plugin from scratch, but I used a lot of the Cabbage example plugins for learning and inspiration.
I also used The CSound FLOSS Manual (https://flossmanual.csound.com/).
*/

<Cabbage> bounds(0, 0, 0, 0)
form caption("Panacea") size(415, 159), guiMode("queue"), pluginId("Pana"), colour(35, 35, 35), bundle("./img")

image bounds(0,0, 420, 110) channel("imgBackgroundTop") colour(232, 232, 232)

checkbox bounds(50, 25, 23, 18) channel("btnSine") radioGroup("Waveform") text("") imgFile("On", "./img/sine_on.svg") imgFile("off", "./img/sine_off.svg") value(1) 
checkbox bounds(50, 45, 23, 18) channel("btnSaw")  radioGroup("Waveform") imgFile("On", "./img/saw_on.svg") imgFile("off", "./img/saw_off.svg")  
checkbox bounds(50, 65, 23, 18) channel("btnRampup") radioGroup("Waveform") imgFile("On", "./img/rampup_on.svg") imgFile("off", "./img/rampup_off.svg")
checkbox bounds(75, 25, 23, 18) channel("btnRampdown") radioGroup("Waveform") imgFile("On", "./img/rampdown_on.svg") imgFile("off", "./img/rampdown_off.svg") 
checkbox bounds(75, 45, 23, 18) channel("btnSquare") radioGroup("Waveform") imgFile("On", "./img/square_on.svg") imgFile("off", "./img/square_off.svg")
checkbox bounds(75, 65, 23, 18) channel("btnRnd") radioGroup("Waveform") imgFile("On", "./img/rnd_on.svg") imgFile("off", "./img/rnd_off.svg")

rslider bounds(125, 5, 80, 80) channel("rslFrequency") range(0.001, 20, 0.2, 0.4, 0.001)  trackerColour(255, 200, 0, 255) trackerInsideRadius(0.62) trackerOutsideRadius(0.7)  colour(35, 35, 35, 255) popupText("0")
label   bounds(125, 71, 80, 12) channel("lbFrequency") text("RATE") fontColour(0, 0, 0, 170)
label   bounds(125, 83, 80, 11) channel("lbFrequencyValue") text("") fontColour(0, 0, 0, 130)

rslider bounds(210, 5, 80, 80) channel("rslDepth") range(0, 1, 0.5, 1, 0.001)  trackerColour(255, 200, 0, 255) trackerInsideRadius(0.62) trackerOutsideRadius(0.7)  colour(35, 35, 35, 255) popupText("0")
label   bounds(210, 71, 80, 12) channel("lbDepth") text("DEPTH") fontColour(0, 0, 0, 170)
label   bounds(210, 83, 80, 11) channel("lbDepthValue") text("") fontColour(0, 0, 0, 130)

rslider bounds(295, 5, 80, 80) channel("rslHumanize") range(0, 1, 0.5, 1, 0.001)  trackerColour(255, 200, 0, 255) trackerInsideRadius(0.62) trackerOutsideRadius(0.7)  colour(35, 35, 35, 255) popupText("0")
label   bounds(295, 71, 80, 12) channel("lbHumanize") text("HUMANIZE") fontColour(0, 0, 0, 170)
label   bounds(295, 83, 80, 11) channel("lbHumanizeValue") text("") fontColour(0, 0, 0, 130)

image bounds(60, 113, 40, 40) channel("imgLogo") file("img/ci_logo.svg") alpha(0.9) outlineColour(0,0,0,0)

image bounds(163, 129, 10, 10) channel("imgScaleLeft") colour(100, 100, 100, 255) shape("circle") outlineColour(0,0,0,0)
image bounds(252, 130, 8, 8) channel("imgScaleMid") colour(100, 100, 100, 255) shape("circle") outlineColour(0,0,0,0)
image bounds(341, 129, 10, 10) channel("imgScaleRight") colour(100, 100, 100, 255) shape("circle") outlineColour(0,0,0,0)
hslider bounds(161, 124, 190, 20) channel("hslVisualizer") range(-0.5, 0.5, 0, 1, 0.001) trackerBackgroundColour(100, 100, 100, 255) colour(255, 200, 0, 255) trackerColour(0, 0, 0, 1) active(0) popupText("0") trackerCentre(0)

</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
ksmps = 32
nchnls = 2
0dbfs = 1

seed 1

instr 1

a1 inch 1
a2 inch 2

iSine ftgen 0, 0, 1024, 10, 1
iSaw ftgen 0, 0, 1024, 7, -1, 512, 1, 512, -1
iSq ftgen 0, 0, 1024, 7, -1, 512, -1, 0, 1, 512, 1
iRampUp ftgen 0, 0, 1024, 7, -1, 1024, 1
iRampDown ftgen 0, 0, 1024, 7, 1, 1024, -1
iRnd ftgen 0, 0, 1024, 21, 6

kSine chnget "btnSine"
kSaw chnget "btnSaw"
kRampup chnget "btnRampup"
kRampdown chnget "btnRampdown"
kSquare chnget "btnSquare"
kBtnRnd chnget "btnRnd"
kFrequency chnget "rslFrequency"
kDepth chnget "rslDepth"
kHumanize chnget "rslHumanize"

;show frequency values
kTrig changed kFrequency
if kTrig == 1 then
    SMess sprintfk "%.3f", kFrequency
    cabbageSet kTrig, "lbFrequencyValue", "text", SMess
endif

;show depth values
kTrig changed kDepth
if kTrig == 1 then
    SMess sprintfk "%.2f", kDepth
    cabbageSet kTrig, "lbDepthValue", "text", SMess
endif 

;show humanize values
kTrig changed kHumanize
if kTrig == 1 then
    SMess sprintfk "%.2f", kHumanize
    cabbageSet kTrig, "lbHumanizeValue", "text", SMess
endif 

;Initialise random generator
kRnd randomi -kHumanize, kHumanize, 0.5, 3

;Set LFO frequency
kLFOFrequency = kFrequency + kFrequency*kRnd

;Check if waveform buttons have been pressed and initialise LFO
kTrig changed kSine, kSaw, kSquare, kRampup, kRampdown
if kTrig == 1 then
    reinit UpdateWaveform
endif
aTrig = a(kTrig)
UpdateWaveform:
    if kSine == 1 then
        alfo oscilikts kDepth, kLFOFrequency, iSine, aTrig, -0.25
        alfo = alfo/2+0.5
    elseif kSaw == 1 then
        alfo oscilikts kDepth, kLFOFrequency, iSaw, aTrig, 0
        alfo = alfo/2+0.5
    elseif kSquare == 1 then
        alfo oscilikts kDepth, kLFOFrequency, iSq, aTrig, 0
        alfo = alfo/2+0.5
        alfo = lag(alfo, 0.01)
    elseif kRampup == 1 then
        alfo oscilikts kDepth, kLFOFrequency, iRampUp, aTrig, 0
        alfo = alfo/2+0.5        
        alfo = lag(alfo, 0.01)
    elseif kRampdown == 1 then
        alfo oscilikts kDepth, kLFOFrequency, iRampDown , aTrig, 0
        alfo = alfo/2+0.5 
        alfo = lag(alfo, 0.01)
    elseif kBtnRnd == 1 then
        alfo oscilikts kDepth, kLFOFrequency/100, iRnd , aTrig, 0
        alfo = alfo/2+0.5 
        alfo = lag(alfo, 0.01)
    endif
rireturn

;Do the panning and set Visualizer position
cabbageSet metro(75), "hslVisualizer", "value", alfo-0.5
aPanL = cos(alfo * $M_PI_2)
aPanR = sin(alfo * $M_PI_2)

outs a1*aPanL*1.33, a2*aPanR*1.33
endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
