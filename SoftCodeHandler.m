function SoftCodeHandler(softCode)
%soft codes 1-10 reserved for odor delivery
%soft code 11-20 reserved for PulsePal sound delivery

global BpodSystem
global TaskParameters

if softCode < 11 %for olfactory
    if BpodSystem.Data.Custom.OlfactometerStartup %if there has been a non-auditory trial and thus olfactometer initialized
        
        firstbank = ['Bank' num2str(TaskParameters.GUI.OdorA_bank)];
        secbank = ['Bank' num2str(TaskParameters.GUI.OdorB_bank)];
        
        if softCode < 9
            if ~BpodSystem.EmulatorMode
%                 softCode = softCode-1; % Olfactometer valve number 1 to 8 are called with softCode number 0 to 7 
                CommandValve = Valves2EthernetString(firstbank, softCode-1, secbank, softCode-1); % softCode := desired valve number - 1
                TCPWrite(BpodSystem.Data.Custom.OlfIp, 3336, CommandValve);
            end
        elseif softCode == 9
            nextTrial = numel(BpodSystem.Data.Custom.TrialNumber) + 2;
            OdorA_flow = BpodSystem.Data.Custom.OdorFracA(nextTrial);
            OdorB_flow = 100 - OdorA_flow;
            if ~BpodSystem.EmulatorMode
                SetBankFlowRate(BpodSystem.Data.Custom.OlfIp, TaskParameters.GUI.OdorA_bank, OdorA_flow)
                SetBankFlowRate(BpodSystem.Data.Custom.OlfIp, TaskParameters.GUI.OdorB_bank, OdorB_flow)
            end
        end
        
    end %if olfactometer initialized
end %if olfactory soft codes

if softCode > 10 && softCode < 21 %for auditory
    if ~BpodSystem.EmulatorMode
        if softCode == 11 %noise on chan 1
            ProgramPulsePal(BpodSystem.Data.Custom.PulsePalParamFeedback);
            SendCustomPulseTrain(1,cumsum(randi(9,1,1000))/10000,(rand(1,1000)-.5)*12); % White(?) noise on channel 1+2
            SendCustomPulseTrain(2,cumsum(randi(9,1,1000))/10000,(rand(1,1000)-.5)*12);
            TriggerPulsePal(1,2);
            ProgramPulsePal(BpodSystem.Data.Custom.PulsePalParamStimulus);
        elseif softCode == 12 %beep on chan 2
            ProgramPulsePal(BpodSystem.Data.Custom.PulsePalParamFeedback);
            SendCustomPulseTrain(2,0:.001:.3,(ones(1,301)*1));  % Beep on channel 1+2
            SendCustomPulseTrain(1,0:.001:.3,(ones(1,301)*1));
            TriggerPulsePal(1,2);
            ProgramPulsePal(BpodSystem.Data.Custom.PulsePalParamStimulus);
        end
    end
end
% switch odorID
%     case 0
%         CommandValveMinOil = Valves2EthernetString(firstbank, 2, secbank, 2);
%         TCPWrite(BpodSystem.Data.Custom.OlfIp, 3336, CommandValveMinOil);
%     case 1
%         CommandValveScent = Valves2EthernetString(firstbank, 1, secbank, 1); % From RechiaOlfactometer plugin. Simultaneously sets banks 1 and 2 to valve 1
%         TCPWrite(BpodSystem.Data.Custom.OlfIp, 3336, CommandValveScent);
end

