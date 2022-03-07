function [srsSeq srsInfo idx] = srs_gen(cs)
% ---------------------------
%%SRS config 
ue.DuplexMode = 'FDD'; %ok   continues generation as FDD mode (but will apply as TDD)
ue.CyclicPrefixUL = 'Normal'; %ok 
ue.NTxAnts = 1; %ok   in this LAB just 1 UE antenna is considered
ue.NFrame = 0; %? 
ue.NULRB = 50; %ok 
ue.NSubframe = 0; %? 
%%SRS Configuration 
srs = struct; 
srs.NTxAnts = 1; % Number of transmit antennas 
if round(cs) < 0 || round(cs) >7
    disp('Error in srs_gen(): Cyclic Shift can be any integer between 0 and 7')
    return
end
srs.CyclicShift = cs; %ok % UE-cyclic shift can be from 0 to 7 for different UE 
srs.ConfigIdx = 0; %ok % UE-specific SRS period = 20ms, offset = 0 
srs.BW = 0; %ok % UE-specific SRS bandwidth configuration 
srs.HoppingBW = 0; %ok % SRS frequency hopping configuration 
srs.FreqPosition = 0; %ok % Frequency domain position 
srs.SubframeConfig = 15; %ok % Cell-specific SRS period = 5ms, offset = 0 
srs.BWConfig = 0; %ok % Cell-specific SRS bandwidth configuration 
% srs.TxComb = 0; % Even indices for comb transmission 
[srsSeq, srsInfo] = lteSRS(ue,srs); 
idx = 13:2:600-12;

end
