/*
Panacea is an autopan audio effect plugin with the possibility of humanization.

Creator: Consistent Interruption
License: GPLv3

Created with Cabbage (https://github.com/rorywalsh/cabbage) and CSound (https://csound.com/). 
I wrote the plugin from scratch, but I used a lot of the Cabbage example plugins for learning and inspiration.
I also used The CSound FLOSS Manual (https://flossmanual.csound.com/).
*/

<Cabbage> bounds(0, 0, 0, 0)
form caption("Panacea") size(475, 266) guiMode("queue") pluginId("Pana") colour(35, 35, 35) bundle("./img")
/*"./img/rslider.svg"*/
#define RSLIDER imgFile("Slider", "./img/rslider_circle_small.svg") imgFile("Background", "./img/rslider_back.svg") trackerColour(232, 232, 232, 255) /*trackerColour(232, 232, 232, 255)*/ trackerInsideRadius(0.7) trackerOutsideRadius(1)  colour(35, 35, 35, 255) popupText("0")

button bounds(9, 8, 35, 14) channel("Sync") text("SYNC", "SYNC") colour:0(35, 35, 35) colour:1(232, 232, 232) fontColour:1(35, 35, 35) fontColour:0(150, 150, 150) corners(1) value(0)
button bounds(420, 8, 45, 14) channel("Bypass") text("BYPASS", "BYPASS") colour:0(35, 35, 35) colour:1(232, 232, 232) fontColour:1(35, 35, 35) fontColour:0(150, 150, 150) corners(1) value(0)

image bounds(0, 28, 475, 196) channel("imgBackgroundMid") colour(232, 232, 232) outlineThickness(3) outlineColour(35, 35, 35)

rslider bounds(72, 43, 50, 50) channel("Pan") range(-0.5, 0.5, 0, 1, 0.001) $RSLIDER
label   bounds(57, 95, 80, 12) channel("lbPan") text("PAN") fontColour(0, 0, 0, 170)
label   bounds(57, 108, 80, 12) channel("lbPanValue") text("Center") fontColour(0, 0, 0, 130)

rslider bounds(357, 43, 50, 50) channel("Gain") range(-1, 1, 0.33, 1, 0.01) $RSLIDER
label   bounds(342, 95, 80, 12) channel("lbGain") text("GAIN") fontColour(0, 0, 0, 170)
label   bounds(342, 108, 80, 12) channel("lbGainValue") text("1.33") fontColour(0, 0, 0, 130)

rslider bounds(200, 63, 80, 80) channel("Waveform") range(0, 6, 1, 1, 1) imgFile("Slider", "./img/rslider_circle.svg") colour(35, 35, 35, 255)  trackerThickness(0) trackerColour(0, 0, 0, 0) trackerBackgroundColour(0, 0, 0, 0) outlineColour(0, 0, 0, 0) popupText("0")
button bounds(198, 135, 23, 18) channel("sine") imgFile("on", "./img/sine.svg") imgFile("off", "./img/sine.svg") text("") 
button bounds(175, 99, 23, 18) channel("saw") imgFile("on", "./img/saw.svg") imgFile("off", "./img/saw.svg") text("")
button bounds(186, 61, 23, 19) channel("expFast") imgFile("on", "./img/exp_mid_fast.svg") imgFile("off", "./img/exp_mid_fast.svg") text("")
button bounds(228, 43, 23, 19) channel("expSlow") imgFile("on", "./img/exp_mid_slow.svg") imgFile("off", "./img/exp_mid_slow.svg") text("")
button bounds(270, 58, 23, 18) channel("rampup") imgFile("on", "./img/rampup.svg") imgFile("off", "./img/rampup.svg") text("")
button bounds(283, 99, 23, 18) channel("rampdown") imgFile("on", "./img/rampdown.svg") imgFile("off", "./img/rampdown.svg") text("")
button bounds(263, 135, 23, 18) channel("square") imgFile("on", "./img/square.svg") imgFile("off", "./img/square.svg") text("")

rslider bounds(35, 132, 50, 50) channel("Rate") range(0.001, 20, 0.2, 0.4, 0.001) $RSLIDER
rslider bounds(35, 132, 50, 50) channel("RateSync") range(0, 31, 18, 1, 1) $RSLIDER visible(0) 
label   bounds(20, 184, 80, 12) channel("lbRate") text("RATE") fontColour(0, 0, 0, 170)
label   bounds(20, 197, 80, 12) channel("lbRateValue") text("") fontColour(0, 0, 0, 130)
;label   bounds(125, 133, 80, 11) channel("lbTest3") text("hallo") fontColour(0, 0, 0, 130)

rslider bounds(110, 132, 50, 50) channel("Depth") range(0, 1, 0.5, 1, 0.001) $RSLIDER
label   bounds(95, 184, 80, 12) channel("lbDepth") text("DEPTH") fontColour(0, 0, 0, 170)
label   bounds(95, 197, 80, 12) channel("lbDepthValue") text("") fontColour(0, 0, 0, 130)
;label   bounds(210, 133, 80, 11) channel("lbTest2") text("hallo") fontColour(0, 0, 0, 130)

rslider bounds(320, 132, 50, 50) channel("Phase") range(0, 0.9375, 0, 1, 0.0625) $RSLIDER alpha(0.5) active(0)
label   bounds(305, 184, 80, 12) channel("lbPhase") text("PHASE") fontColour(0, 0, 0, 170) alpha(0.5)
label   bounds(305, 197, 80, 12) channel("lbPhaseValue") text("0.00") fontColour(0, 0, 0, 130) alpha(0.5)

rslider bounds(395, 132, 50, 50) channel("Humanize") range(0, 1, 0.5, 1, 0.001) $RSLIDER
label   bounds(380, 184, 80, 12) channel("lbHumanize") text("HUMANIZE") fontColour(0, 0, 0, 170)
label   bounds(380, 197, 80, 12) channel("lbHumanizeValue") text("") fontColour(0, 0, 0, 130)
;label   bounds(295, 143, 80, 11) channel("lbTest") text("hallo") fontColour(0, 0, 0, 130)

image bounds(80, 225, 40, 40) channel("imgLogo") file("img/ci_logo.svg") alpha(0.9) outlineColour(0,0,0,0)
image bounds(196, 244, 200, 4) channel("svgVisualizer") corners(3) colour(100, 100, 100) outlineColour(60, 60, 60) outlineThickness(1)
image bounds(295, 245, 2, 2) channel("imgMidLine") colour(232, 232, 232)
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
ksmps = 16
nchnls = 2
0dbfs = 1

seed 0

instr 1

a1 inch 1
a2 inch 2

;####################
;
;   Variables
;
;####################

;Wavetables
iSine ftgen 101, 0, 1024, 9, 1, 1, -90
iSaw ftgen 102, 0, 1024, 7, -1, 512, 1, 512, -1
iExpMidFast ftgen 103, 0, 1024, 16, -1, 256, 5, 0, 256, -5, 1, 256, 5, 0, 256, -5, -1
iExpMidSlow ftgen 104, 0, 1024, 16, -1, 256, -5, 0, 256, 5, 1, 256, -5, 0, 256, 5, -1
iRampUp ftgen 105, 0, 1024, 7, -1, 1024, 1
iRampDown ftgen 106, 0, 1024, 7, 1, 1024, -1
iSq ftgen 107, 0, 1024, 7, -1, 512, -1, 0, 1, 512, 1

;Sync constants            0       1       2       3       4       5       6       7      8      9      10     11     12     13     14     15     16      17             18     19      20             21     22      23             24     25       26             27      28       29             30      31
SyncNames[] fillarray     "16/1", "15/1", "14/1", "13/1", "12/1", "11/1", "10/1", "9/1", "8/1", "7/1", "6/1", "5/1", "4/1", "3/1", "2/1", "1/1", "1/2.", "1/1 T",       "1/2", "1/4.", "1/2 T",       "1/4", "1/8.", "1/4 T",       "1/8", "1/16.", "1/8 T",       "1/16", "1/32.", "1/16 T",      "1/32", "1/32 T"
iSyncBPMDiv[] fillarray    3840,   3600,   3360,   3120,   2880,   2640,   2400,   2160,  1920,  1680,  1440,  1200,  960,   720,   480,   240,   180,    160,           120,   90,     80,            60,    45,     40,            30,    22.5,    20,            15,     11.25,   10,            7.5,    5
iSyncRelation[] fillarray  64,     60,     56,     52,     48,     44,     40,     36,    32,    28,    24,    20,    16,    12,    8,     4,     3,      2.66666666666, 2,     1.5,    1.33333333333, 1,     0.75,   0.66666666666, 0.5,   0.375,   0.33333333333, 0.25,   0.1875,  0.16666666666, 0.125,  0.08333333333

kSyncRndIntervall init 1
kCount init 0

;Widgets
kSync chnget "Sync"
kBypass chnget "Bypass"
kPan chnget "Pan"
kGain chnget "Gain"
kWaveform chnget "Waveform"
kRate chnget "Rate"
kRateSync chnget "RateSync"
kDepth chnget "Depth"
kBtnPhase chnget "Phase"
kHumanize chnget "Humanize"

;Hostinfos
kIsPlaying chnget "IS_PLAYING"
kBPM chnget "HOST_BPM"
kPPQPosition chnget "HOST_PPQ_POS"

;Wavetabel images
kSine chnget "sine"
kSaw chnget "saw"
kExpFast chnget "expFast"
kExpSlow chnget "expSlow"
kRampUp chnget "rampup"
kRampDown chnget "rampdown"
kSquare chnget "square"


;####################
;
;   Macros
;
;####################

;Macro set LFO phase
#define SETLFOPHASE #
    kPPQLastBar = kPPQPosition/iSyncRelation[kRateSync]
    kPPQLastBar = floor(kPPQLastBar)*iSyncRelation[kRateSync]
    kPhase = (kPPQPosition - kPPQLastBar)*(1/iSyncRelation[kRateSync])
    kPhase = kPhase+kBtnPhase-1
    ;cabbageSet 1, "lbTest3", "text", kPhase
#

;Macro set sync Frequenzy
#define SETSYNCFREQ #
    kRateSyncFreq = divz(kBPM, iSyncBPMDiv[kRateSync], 1)
    ;cabbageSet 1, "lbTest2", "text", kRateSyncFreq
#

;####################
;
;   User interaction
;
;####################

;show pan values
kTrig changed kPan
if kTrig == 1 then
    if kPan == 0 then
        cabbageSet kTrig, "lbPanValue", "text", "Center"
    elseif kPan == -0.5 then
        cabbageSet kTrig, "lbPanValue", "text", "Left"
    elseif kPan == 0.5 then
        cabbageSet kTrig, "lbPanValue", "text", "Right"
    else
        SMess sprintfk "%.2f", kPan*2
        cabbageSet kTrig, "lbPanValue", "text", SMess
    endif
endif

;show gain values
kTrig changed kGain
if kTrig == 1 then
    SMess sprintfk "%.2f", kGain+1
    cabbageSet kTrig, "lbGainValue", "text", SMess
endif

;show depth values
kTrig changed kDepth
if kTrig == 1 then
    SMess sprintfk "%.2f", kDepth
    cabbageSet kTrig, "lbDepthValue", "text", SMess
endif 

;show phase values
kTrigU changed kBtnPhase
if kTrigU == 1 then
    SMess sprintfk "%.2f", kBtnPhase
    cabbageSet kTrigU, "lbPhaseValue", "text", SMess
    if kSync == 1 then
        if kIsPlaying == 1 then
            $SETLFOPHASE
        endif
    endif
endif

;show humanize values
kTrig changed kHumanize
if kTrig == 1 then
    SMess sprintfk "%.2f", kHumanize
    cabbageSet kTrig, "lbHumanizeValue", "text", SMess
endif

;Show RateSync values and set LFO phase
kTrigR changed kRateSync
if kTrigR == 1 then
    cabbageSet kTrigR, "lbRateValue", "text", SyncNames[kRateSync]
    $SETSYNCFREQ
    kLFOFrequency = kRateSyncFreq
    
    if kIsPlaying == 1 then
        $SETLFOPHASE
    endif
endif

;show rate values
kTrig changed kRate
if kTrig == 1 then
    SMess sprintfk "%.3f", kRate
    cabbageSet kTrig, "lbRateValue", "text", SMess
endif

;enable click on waveforms
if changed(kSine) == 1 then
    cabbageSetValue "Waveform", 0, 1
endif
if changed(kSaw) == 1 then
    cabbageSetValue "Waveform", 1, 1
endif
if changed(kExpFast) == 1 then
    cabbageSetValue "Waveform", 2, 1
endif
if changed(kExpSlow) == 1 then
    cabbageSetValue "Waveform", 3, 1
endif
if changed(kRampUp) == 1 then
    cabbageSetValue "Waveform", 4, 1
endif
if changed(kRampDown) == 1 then
    cabbageSetValue "Waveform", 5, 1
endif
if changed(kSquare) == 1 then
    cabbageSetValue "Waveform", 6, 1
endif

;switch between synced and unsynced
kTrigH changed kSync
if kTrigH == 1 then
    if kSync == 1 then
        $SETSYNCFREQ
        kLFOFrequency = kRateSyncFreq
        if kIsPlaying == 1 then
            $SETLFOPHASE
        endif
        cabbageSet kTrigH, "Rate", "visible", 0
        cabbageSet kTrigH, "RateSync", "visible", 1
        cabbageSet kTrigH, "lbRateValue", "text", SyncNames[kRateSync]
        cabbageSet kTrigH, "Phase", "active", 1
        cabbageSet kTrigH, "Phase", "alpha", 1
        cabbageSet kTrigH, "lbPhase", "alpha", 1
        cabbageSet kTrigH, "lbPhaseValue", "alpha", 1
    else
        cabbageSet kTrigH, "Rate", "visible", 1
        cabbageSet kTrigH, "RateSync", "visible", 0
        SMess sprintfk "%.3f", kRate
        cabbageSet kTrigH, "lbRateValue", "text", SMess
        cabbageSet kTrigH, "Phase", "active", 0
        cabbageSet kTrigH, "Phase", "alpha", 0.5
        cabbageSet kTrigH, "lbPhase", "alpha", 0.5
        cabbageSet kTrigH, "lbPhaseValue", "alpha", 0.5
    endif
endif

;####################
;
;   Prepare lfo attributes and panning
;
;####################

;initialise random generator
kRnd randomi -kHumanize, kHumanize, 0.5, 3

;set LFO frequency
if kSync == 0 then
    kLFOFrequency = kRate + kRate*kRnd
else
    if kIsPlaying == 1 then
        kTrigS = 0
        kIntervall metro kSyncRndIntervall
        if kIntervall == 1 then
            if kCount == 0 then
                reinit KTOI
                KTOI:
                    iFreq = i(kRateSyncFreq)*i(kRnd)
                rireturn
                kLFOFrequency = kRateSyncFreq + iFreq
                kCount = 1
            elseif kCount == 1 then
                kLFOFrequency = kRateSyncFreq - iFreq
                kCount = 2
            elseif kCount == 2 then
                kLFOFrequency = kRateSyncFreq
                $SETLFOPHASE
                kTrigS = 4969
                kSyncRndIntervall random 0.5, 1.5
                kCount = 0
            endif
        endif
    endif
endif

;check if host bpm has changed
kTrig changed kBPM
if kTrig == 1 then
    if kSync == 1 then
        $SETSYNCFREQ
        if kIsPlaying == 1 then
            $SETLFOPHASE
        endif
    endif
endif

;check if host is playing
kTrigP changed kIsPlaying
if kTrigP == 1 then
    if kSync == 1 then
        if kIsPlaying == 1 then
            $SETLFOPHASE
        endif
    endif
endif

;set waveform spezifics and LFO phase
kTrigB changed kWaveform
if kTrigB == 1 then
    if kWaveform < 3 then
        iLag = 0
    else
        iLag = 0.01
    endif
    if kSync == 1 then
        if kIsPlaying == 1 then
            $SETLFOPHASE
        endif
    endif
endif

;Initialise LFO
aTrig = a(kTrigR) + a(kTrigP) + a(kTrigB) + a(kTrigS) + a(kTrigH) + a(kTrig) + a(kTrigU)
kDepthPan = kDepth-(abs(kPan)*kDepth)

alfo oscilikts kDepthPan, kLFOFrequency, iSine+kWaveform, aTrig, kPhase
alfo = alfo/2+0.5+kPan+(kDepthPan*kPan*-1)
alfo = lag(alfo, iLag)

;Do the panning and set Visualizer position
kTrig changed kBypass
if kBypass == 0 then
    aPanL = sqrt((1-alfo))
    aPanR = sqrt(alfo)
    
    cabbageSet metro(64), "svgVisualizer", "svgElement", sprintfk({{<path d="M 100 2 L %d 2" stroke="rgb(232,232,232)" stroke-width="2" fill="none" stroke-linecap="round"/>}}, k(alfo)*200)

    outs a1*aPanL*(kGain+1), a2*aPanR*(kGain+1)
else
    cabbageSet kTrig, "svgVisualizer", "svgElement", {{<path d="M 100 2 L 100 2" stroke="rgb(232,232,232)" stroke-width="2" fill="none" stroke-linecap="round"/>}}
    outs a1, a2
endif
endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
