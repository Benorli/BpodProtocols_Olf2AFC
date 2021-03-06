function MainPlot(AxesHandles, Action, varargin)
global nTrialsToShow %this is for convenience
global BpodSystem
global TaskParameters

switch Action
    case 'init'
        
        %% Outcome
        %initialize pokes plot
        nTrialsToShow = 90; %default number of trials to display
        
        if nargin >=3  %custom number of trials
            nTrialsToShow =varargin{1};
        end
        axes(AxesHandles.HandleOutcome);
        %         Xdata = 1:numel(SideList); Ydata = SideList(Xdata);
        %plot in specified axes
        BpodSystem.GUIHandles.OutcomePlot.Olf = line(-1,1,...
            'LineStyle','none',...
            'Marker','o',...
            'MarkerEdge','k',...
            'MarkerFace','k',...
            'MarkerSize',8);
        BpodSystem.GUIHandles.OutcomePlot.Aud = line(-1,1,...
            'LineStyle','none',...
            'Marker','o',...
            'MarkerEdge',[.5,.5,.5],...
            'MarkerFace',[.7,.7,.7],...
            'MarkerSize',8);
        BpodSystem.GUIHandles.OutcomePlot.DV = line(1:numel(BpodSystem.Data.Custom.DV),BpodSystem.Data.Custom.DV,...
            'LineStyle','none',...
            'Marker','o',...
            'MarkerEdge','b',...
            'MarkerFace','b',...
            'MarkerSize',6);
        BpodSystem.GUIHandles.OutcomePlot.CurrentTrialCircle = line(1,0,...
            'LineStyle','none',...
            'Marker','o',...
            'MarkerEdge','k',...
            'MarkerFace',[1 1 1],...
            'MarkerSize',6);
        BpodSystem.GUIHandles.OutcomePlot.CurrentTrialCross = line(1,0,...
            'LineStyle','none',...
            'Marker','+','MarkerEdge',...
            'k','MarkerFace',...
            [1 1 1],...
            'MarkerSize',6);
        BpodSystem.GUIHandles.OutcomePlot.CumRwdL = text(12,1.2,'Left: 0mL',...
            'verticalalignment','bottom',...
            'horizontalalignment','right');
        BpodSystem.GUIHandles.OutcomePlot.CumRwdR = text(12,1.1,'Right: 0mL',...
            'verticalalignment','bottom',...
            'horizontalalignment','right');
        BpodSystem.GUIHandles.OutcomePlot.nTrialsL = text(12,0.9,'Left trials: 0',...
            'verticalalignment','bottom',...
            'horizontalalignment','right');
        BpodSystem.GUIHandles.OutcomePlot.nTrialsR = text(12,0.8,'Right trials: 0',...
            'verticalalignment','bottom',...
            'horizontalalignment','right');
        BpodSystem.GUIHandles.OutcomePlot.ChoiceLeft = text(12,0.6,'Chose left: 0',...
            'verticalalignment','bottom',...
            'horizontalalignment','right');
        BpodSystem.GUIHandles.OutcomePlot.ChoiceRight = text(12,0.5,'Chose right: 0',...
            'verticalalignment','bottom',...
            'horizontalalignment','right');
        BpodSystem.GUIHandles.OutcomePlot.PercCorrect = text(12,0.3,'Correct:',...
            'verticalalignment','bottom',...
            'horizontalalignment','right');
        BpodSystem.GUIHandles.OutcomePlot.Correct = line(-1,1,...
            'LineStyle','none',...
            'Marker','o',...
            'MarkerEdge','g',...
            'MarkerFace','g',...
            'MarkerSize',6);
        BpodSystem.GUIHandles.OutcomePlot.Incorrect = line(-1,1,...
            'LineStyle','none',...
            'Marker','o',...
            'MarkerEdge','r',...
            'MarkerFace','r',...
            'MarkerSize',6);
        BpodSystem.GUIHandles.OutcomePlot.BrokeFix = line(-1,0,...
            'LineStyle','none',...
            'Marker','d',...
            'MarkerEdge','b',...
            'MarkerFace','none',...
            'MarkerSize',6);
        BpodSystem.GUIHandles.OutcomePlot.EarlyWithdrawal = line(-1,0,...
            'LineStyle','none',...
            'Marker','d',...
            'MarkerEdge','none',...
            'MarkerFace','b',...
            'MarkerSize',6);
        BpodSystem.GUIHandles.OutcomePlot.NoFeedback = line(-1,0,...
            'LineStyle','none',...
            'Marker','o',...
            'MarkerEdge','none',...
            'MarkerFace','w',...
            'MarkerSize',5);
        BpodSystem.GUIHandles.OutcomePlot.NoResponse = line(-1,[0 1],...
            'LineStyle','none',...
            'Marker','x',...
            'MarkerEdge','w',...
            'MarkerFace','none',...
            'MarkerSize',6);
        BpodSystem.GUIHandles.OutcomePlot.Catch = line(-1,[0 1],...
            'LineStyle','none',...
            'Marker','o',...
            'MarkerEdge',[0,0,0],...
            'MarkerFace',[0,0,0],...
            'MarkerSize',4);
        set(AxesHandles.HandleOutcome,...
            'TickDir', 'out',...
            'XLim',[0, nTrialsToShow],...
            'YLim', [-1.25, 1.25],...
            'YTick', [-1, 1],...
            'YTickLabel', {'Right','Left'},...
            'FontSize', 13);
        set(BpodSystem.GUIHandles.OutcomePlot.Olf,...
            'xdata',find(~BpodSystem.Data.Custom.AuditoryTrial),...
            'ydata',BpodSystem.Data.Custom.DV(~BpodSystem.Data.Custom.AuditoryTrial));
        set(BpodSystem.GUIHandles.OutcomePlot.Aud,...
            'xdata',find(BpodSystem.Data.Custom.AuditoryTrial),...
            'ydata',BpodSystem.Data.Custom.DV(BpodSystem.Data.Custom.AuditoryTrial));
        xlabel(AxesHandles.HandleOutcome, 'Trial#', 'FontSize', 14);
        hold(AxesHandles.HandleOutcome, 'on');
        %% Psyc Olfactory
        BpodSystem.GUIHandles.OutcomePlot.PsycOlf = line(AxesHandles.HandlePsycOlf,[5 95],[.5 .5],...
            'LineStyle','none',...
            'Marker','o',...
            'MarkerEdge','k',...
            'MarkerFace','k',...
            'MarkerSize',6,...
            'Visible','off');
        BpodSystem.GUIHandles.OutcomePlot.PsycOlfFit = line(AxesHandles.HandlePsycOlf,[0 100],[.5 .5],...
            'color','k',...
            'Visible','off');
        AxesHandles.HandlePsycOlf.YLim = [0 1.05];
        AxesHandles.HandlePsycOlf.XLim = 100*[-.05 1.05];
        AxesHandles.HandlePsycOlf.XLabel.String = '% odor A'; % FIGURE OUT UNIT
        AxesHandles.HandlePsycOlf.YLabel.String = '% left';
        AxesHandles.HandlePsycOlf.Title.String = 'Psychometric Olf';
        %% Psyc Auditory
        BpodSystem.GUIHandles.OutcomePlot.PsycAud = line(AxesHandles.HandlePsycAud,[-1 1],[.5 .5],...
            'LineStyle','none',...
            'Marker','o',...
            'MarkerEdge','k',...
            'MarkerFace','k',...
            'MarkerSize',6,...
            'Visible','off');
        BpodSystem.GUIHandles.OutcomePlot.PsycAudMidLine = line(AxesHandles.HandlePsycAud,[-1. 1.],[.5 .5],...
            'color',[0.8, 0.8, 0.8],...
            'Visible','off');
        BpodSystem.GUIHandles.OutcomePlot.PsycAudTopLine = line(AxesHandles.HandlePsycAud,[-1. 1.],[.9 .9],...
            'color',[0.85, 0.85, 0.85],...
            'Visible','off');        
        BpodSystem.GUIHandles.OutcomePlot.PsycAudBottomLine = line(AxesHandles.HandlePsycAud,[-1. 1.],[.1 .1],...
            'color',[0.85, 0.85, 0.85],...
            'Visible','off');
        BpodSystem.GUIHandles.OutcomePlot.PsycAudFit = line(AxesHandles.HandlePsycAud,[-1. 1.],[.5 .5],...
            'color','k',...
            'Visible','off');
        AxesHandles.HandlePsycAud.YLim = [0 1.05];
        AxesHandles.HandlePsycAud.XLim = [-1.05, 1.05];
        AxesHandles.HandlePsycAud.XLabel.String = '[left]       Evidence       [right]'; % FIGURE OUT UNIT
        AxesHandles.HandlePsycAud.YLabel.String = '% Right Choice';
        AxesHandles.HandlePsycAud.Title.String = 'Psychometric Aud';
        %% Vevaiometric curve
        hold(AxesHandles.HandleVevaiometric,'on')
        BpodSystem.GUIHandles.OutcomePlot.VevaiometricCatch = line(AxesHandles.HandleVevaiometric,-2,-1,...
            'LineStyle','-',...
            'Color','g',...
            'Visible','off',...
            'LineWidth',2);
        BpodSystem.GUIHandles.OutcomePlot.VevaiometricErr = line(AxesHandles.HandleVevaiometric,-2,-1,...
            'LineStyle','-',...
            'Color','r',...
            'Visible','off',...
            'LineWidth',2);
        BpodSystem.GUIHandles.OutcomePlot.VevaiometricPointsErr = line(AxesHandles.HandleVevaiometric,-2,-1,...
            'LineStyle','none',...
            'Color','r',...
            'Marker','o',...
            'MarkerFaceColor','r',...
            'MarkerSize',2,...
            'Visible','off',...
            'MarkerEdgeColor','r');
        BpodSystem.GUIHandles.OutcomePlot.VevaiometricPointsCatch = line(AxesHandles.HandleVevaiometric,-2,-1,...
            'LineStyle','none',...
            'Color','g',...
            'Marker','o',...
            'MarkerFaceColor','g',...
            'MarkerSize',2,...
            'Visible','off',...
            'MarkerEdgeColor','g');
        AxesHandles.HandleVevaiometric.YLim = [0 10];
        AxesHandles.HandleVevaiometric.XLim = [-1.05, 1.05];
        AxesHandles.HandleVevaiometric.XLabel.String = '[left]       Evidence       [right]';
        AxesHandles.HandleVevaiometric.YLabel.String = 'WT (s)';
        AxesHandles.HandleVevaiometric.Title.String = 'Vevaiometric';
        %% Trial rate
        hold(AxesHandles.HandleTrialRate,'on')
        BpodSystem.GUIHandles.OutcomePlot.TrialRate = line(AxesHandles.HandleTrialRate,[0],[0],...
            'LineStyle','-',...
            'Color','k',...
            'Visible','off'); %#ok<NBRAK>
        AxesHandles.HandleTrialRate.XLabel.String = 'Time (min)'; % FIGURE OUT UNIT
        AxesHandles.HandleTrialRate.YLabel.String = 'nTrials';
        AxesHandles.HandleTrialRate.Title.String = 'Trial rate';
        %% Stimulus delay
        hold(AxesHandles.HandleFix,'on')
        AxesHandles.HandleFix.XLabel.String = 'Time (ms)';
        AxesHandles.HandleFix.YLabel.String = 'trial counts';
        AxesHandles.HandleFix.Title.String = 'Pre-stimulus delay';
        %% ST histogram
        hold(AxesHandles.HandleST,'on')
        AxesHandles.HandleST.XLabel.String = 'Time (ms)';
        AxesHandles.HandleST.YLabel.String = 'trial counts';
        AxesHandles.HandleST.Title.String = 'Stim sampling time';
        %% Feedback Delay histogram
        hold(AxesHandles.HandleFeedback,'on')
        AxesHandles.HandleFeedback.XLabel.String = 'Time (ms)';
        AxesHandles.HandleFeedback.YLabel.String = 'trial counts';
        AxesHandles.HandleFeedback.Title.String = 'Feedback delay';
    case 'update'
        %% Reposition and hide/show axes
        ShowPlots = [TaskParameters.GUI.ShowPsycOlf,TaskParameters.GUI.ShowPsycAud,TaskParameters.GUI.ShowVevaiometric,...
                     TaskParameters.GUI.ShowTrialRate,TaskParameters.GUI.ShowFix,TaskParameters.GUI.ShowST,TaskParameters.GUI.ShowFeedback];
        NoPlots = sum(ShowPlots);
        NPlot = cumsum(ShowPlots);
        if ShowPlots(1)
            BpodSystem.GUIHandles.OutcomePlot.HandlePsycOlf.Position =      [NPlot(1)*.05+0.005                                    .6   1/(1.65*NoPlots) 0.3];
            BpodSystem.GUIHandles.OutcomePlot.HandlePsycOlf.Visible = 'on';
            set(get(BpodSystem.GUIHandles.OutcomePlot.HandlePsycOlf,'Children'),'Visible','on');
        else
            BpodSystem.GUIHandles.OutcomePlot.HandlePsycOlf.Visible = 'off';
            set(get(BpodSystem.GUIHandles.OutcomePlot.HandlePsycOlf,'Children'),'Visible','off');
        end
        if ShowPlots(2)
            BpodSystem.GUIHandles.OutcomePlot.HandlePsycAud.Position =      [NPlot(2)*.05+0.005 + (NPlot(2)-1)*1/(1.65*NoPlots)    .6   1/(1.65*NoPlots) 0.3];
            BpodSystem.GUIHandles.OutcomePlot.HandlePsycAud.Visible = 'on';
            set(get(BpodSystem.GUIHandles.OutcomePlot.HandlePsycAud,'Children'),'Visible','on');
        else
            BpodSystem.GUIHandles.OutcomePlot.HandlePsycAud.Visible = 'off';
            set(get(BpodSystem.GUIHandles.OutcomePlot.HandlePsycAud,'Children'),'Visible','off');
        end
        if ShowPlots(3)
            BpodSystem.GUIHandles.OutcomePlot.HandleVevaiometric.Position = [NPlot(3)*.05+0.005 + (NPlot(3)-1)*1/(1.65*NoPlots)    .6   1/(1.65*NoPlots) 0.3];
            BpodSystem.GUIHandles.OutcomePlot.HandleVevaiometric.Visible = 'on';
            set(get(BpodSystem.GUIHandles.OutcomePlot.HandleVevaiometric,'Children'),'Visible','on');
        else
            BpodSystem.GUIHandles.OutcomePlot.HandleVevaiometric.Visible = 'off';
            set(get(BpodSystem.GUIHandles.OutcomePlot.HandleVevaiometric,'Children'),'Visible','off');
        end
        if ShowPlots(4)
            BpodSystem.GUIHandles.OutcomePlot.HandleTrialRate.Position =    [NPlot(4)*.05+0.005 + (NPlot(4)-1)*1/(1.65*NoPlots)    .6   1/(1.65*NoPlots) 0.3];
            BpodSystem.GUIHandles.OutcomePlot.HandleTrialRate.Visible = 'on';
            set(get(BpodSystem.GUIHandles.OutcomePlot.HandleTrialRate,'Children'),'Visible','on');
        else
            BpodSystem.GUIHandles.OutcomePlot.HandleTrialRate.Visible = 'off';
            set(get(BpodSystem.GUIHandles.OutcomePlot.HandleTrialRate,'Children'),'Visible','off');
        end
        if ShowPlots(5)
            BpodSystem.GUIHandles.OutcomePlot.HandleFix.Position =          [NPlot(5)*.05+0.005 + (NPlot(5)-1)*1/(1.65*NoPlots)    .6   1/(1.65*NoPlots) 0.3];
            BpodSystem.GUIHandles.OutcomePlot.HandleFix.Visible = 'on';
            set(get(BpodSystem.GUIHandles.OutcomePlot.HandleFix,'Children'),'Visible','on');
        else
            BpodSystem.GUIHandles.OutcomePlot.HandleFix.Visible = 'off';
            set(get(BpodSystem.GUIHandles.OutcomePlot.HandleFix,'Children'),'Visible','off');
        end
        if ShowPlots(6)
            BpodSystem.GUIHandles.OutcomePlot.HandleST.Position =           [NPlot(6)*.05+0.005 + (NPlot(6)-1)*1/(1.65*NoPlots)    .6   1/(1.65*NoPlots) 0.3];
            BpodSystem.GUIHandles.OutcomePlot.HandleST.Visible = 'on';
            set(get(BpodSystem.GUIHandles.OutcomePlot.HandleST,'Children'),'Visible','on');
        else
            BpodSystem.GUIHandles.OutcomePlot.HandleST.Visible = 'off';
            set(get(BpodSystem.GUIHandles.OutcomePlot.HandleST,'Children'),'Visible','off');
        end
        if ShowPlots(7)
            BpodSystem.GUIHandles.OutcomePlot.HandleFeedback.Position =     [NPlot(7)*.05+0.005 + (NPlot(7)-1)*1/(1.65*NoPlots)    .6   1/(1.65*NoPlots) 0.3];
            BpodSystem.GUIHandles.OutcomePlot.HandleFeedback.Visible = 'on';
            set(get(BpodSystem.GUIHandles.OutcomePlot.HandleFeedback,'Children'),'Visible','on');
        else
            BpodSystem.GUIHandles.OutcomePlot.HandleFeedback.Visible = 'off';
            set(get(BpodSystem.GUIHandles.OutcomePlot.HandleFeedback,'Children'),'Visible','off');
        end
        
        %% Outcome
        iTrial = varargin{1};
        [mn, ~] = rescaleX(AxesHandles.HandleOutcome,iTrial,nTrialsToShow); % recompute xlim
        
        set(BpodSystem.GUIHandles.OutcomePlot.CurrentTrialCircle,...
            'xdata', iTrial+1,...
            'ydata', 0);
        set(BpodSystem.GUIHandles.OutcomePlot.CurrentTrialCross,...
            'xdata', iTrial+1,...
            'ydata', 0);
        
        %plot modality background
        set(BpodSystem.GUIHandles.OutcomePlot.Olf,...
            'xdata', find(~BpodSystem.Data.Custom.AuditoryTrial),...
            'ydata', BpodSystem.Data.Custom.DV(~BpodSystem.Data.Custom.AuditoryTrial));
        set(BpodSystem.GUIHandles.OutcomePlot.Aud,...
            'xdata',find(BpodSystem.Data.Custom.AuditoryTrial),...
            'ydata',BpodSystem.Data.Custom.DV(BpodSystem.Data.Custom.AuditoryTrial));
        %plot past&future trials
        set(BpodSystem.GUIHandles.OutcomePlot.DV,...
            'xdata', mn:numel(BpodSystem.Data.Custom.DV),...
            'ydata',BpodSystem.Data.Custom.DV(mn:end));
        
        %Plot past trial outcomes
        indxToPlot = mn:iTrial;
        %Cumulative Reward Amount
        R = BpodSystem.Data.Custom.RewardMagnitude;
        iRwd = BpodSystem.Data.Custom.Rewarded;
        C = zeros(size(R)); 
        C(BpodSystem.Data.Custom.ChoiceLeft==1&iRwd,1) = 1; 
        C(BpodSystem.Data.Custom.ChoiceLeft==0&iRwd,2) = 1;
        R = R.*C;
        lTrials = BpodSystem.Data.Custom.MoreLeftClicks(1:iTrial);
        lTrials = lTrials(~isnan(lTrials));
        lChoice = BpodSystem.Data.Custom.ChoiceLeft;
        lChoice = lChoice(~isnan(lChoice));
        set(BpodSystem.GUIHandles.OutcomePlot.CumRwdL,...
            'position', [iTrial+12 1.2],...
            'string', ['Left: ' num2str(sum(R(:,1))/1000) ' mL']);
        set(BpodSystem.GUIHandles.OutcomePlot.CumRwdR,...
            'position', [iTrial+12 1.1],...
            'string', ['Right: ' num2str(sum(R(:,2))/1000) ' mL']);
        set(BpodSystem.GUIHandles.OutcomePlot.nTrialsL,...
            'position', [iTrial+12 0.9],...
            'string', ['Left trials: ', num2str(sum(lTrials))]);
        set(BpodSystem.GUIHandles.OutcomePlot.nTrialsR,...
            'position', [iTrial+12 0.8],...
            'string', ['Right trials: ', num2str(sum(~lTrials))]);
         set(BpodSystem.GUIHandles.OutcomePlot.ChoiceLeft,...
            'position', [iTrial+12 0.6],...
            'string', ['Chose left: ', num2str(sum(lChoice))]);
        set(BpodSystem.GUIHandles.OutcomePlot.ChoiceRight,...
            'position', [iTrial+12 0.5],...
            'string', ['Chose right: ', num2str(sum(~lChoice))]);
        set(BpodSystem.GUIHandles.OutcomePlot.PercCorrect,...
            'position', [iTrial+12 0.3],...
            'string', sprintf('Correct: %.0f %%',...
            (nansum(BpodSystem.Data.Custom.ChoiceCorrect)/(length(lTrials)...
            -nansum(BpodSystem.Data.Custom.EarlyWithdrawal)...
            -nansum(BpodSystem.Data.Custom.FixBroke)))*100));
        % Add n choice, l/r
        clear R C lTrials lChoice
        %Plot Rewarded
        ndxCor = BpodSystem.Data.Custom.ChoiceCorrect(indxToPlot)==1;
        Xdata = indxToPlot(ndxCor);
        Ydata = BpodSystem.Data.Custom.DV(indxToPlot); Ydata = Ydata(ndxCor);
        set(BpodSystem.GUIHandles.OutcomePlot.Correct, 'xdata', Xdata, 'ydata', Ydata);
        %Plot Incorrect
        ndxInc = BpodSystem.Data.Custom.ChoiceCorrect(indxToPlot)==0;
        Xdata = indxToPlot(ndxInc);
        Ydata = BpodSystem.Data.Custom.DV(indxToPlot); Ydata = Ydata(ndxInc);
        set(BpodSystem.GUIHandles.OutcomePlot.Incorrect, 'xdata', Xdata, 'ydata', Ydata);
        %Plot Broken Fixation
        ndxBroke = BpodSystem.Data.Custom.FixBroke(indxToPlot);
        Xdata = indxToPlot(ndxBroke); Ydata = zeros(1,sum(ndxBroke));
        set(BpodSystem.GUIHandles.OutcomePlot.BrokeFix, 'xdata', Xdata, 'ydata', Ydata);
        %Plot Early Withdrawal
        ndxEarly = BpodSystem.Data.Custom.EarlyWithdrawal(indxToPlot);
        Xdata = indxToPlot(ndxEarly);
        Ydata = zeros(1,sum(ndxEarly));
        set(BpodSystem.GUIHandles.OutcomePlot.EarlyWithdrawal, 'xdata', Xdata, 'ydata', Ydata);
        %Plot missed choice trials
        ndxMiss = isnan(BpodSystem.Data.Custom.ChoiceLeft(indxToPlot))&~ndxBroke&~ndxEarly;
        Xdata = indxToPlot(ndxMiss);
        Ydata = BpodSystem.Data.Custom.DV(indxToPlot); Ydata = Ydata(ndxMiss);
        set(BpodSystem.GUIHandles.OutcomePlot.NoResponse, 'xdata', Xdata, 'ydata', Ydata);
        %Plot NoFeedback trials
        ndxNoFeedback = ~BpodSystem.Data.Custom.Feedback(indxToPlot);
        Xdata = indxToPlot(ndxNoFeedback&~ndxMiss);
        Ydata = BpodSystem.Data.Custom.DV(indxToPlot); Ydata = Ydata(ndxNoFeedback&~ndxMiss);
        set(BpodSystem.GUIHandles.OutcomePlot.NoFeedback, 'xdata', Xdata, 'ydata', Ydata);
        %Plot catch trials
        ndxCatch = BpodSystem.Data.Custom.CatchTrial(indxToPlot);
        Xdata = indxToPlot(ndxCatch&~ndxMiss);
        Ydata = BpodSystem.Data.Custom.DV(indxToPlot); Ydata = Ydata(ndxCatch&~ndxMiss);
        set(BpodSystem.GUIHandles.OutcomePlot.Catch, 'xdata', Xdata, 'ydata', Ydata);
        %% Psyc Olf
        if TaskParameters.GUI.ShowPsycOlf
            OdorFracA = BpodSystem.Data.Custom.OdorFracA(1:numel(BpodSystem.Data.Custom.ChoiceLeft));
            ndxOlf = ~BpodSystem.Data.Custom.AuditoryTrial(1:numel(BpodSystem.Data.Custom.ChoiceLeft));
            if isfield(BpodSystem.Data.Custom,'BlockNumber')
                BlockNumber = BpodSystem.Data.Custom.BlockNumber;
            else
                BlockNumber = ones(size(BpodSystem.Data.Custom.ChoiceLeft));
            end
            setBlocks = reshape(unique(BlockNumber),1,[]); % STOPPED HERE
            ndxNan = isnan(BpodSystem.Data.Custom.ChoiceLeft);
            for iBlock = setBlocks(end)
                ndxBlock = BpodSystem.Data.Custom.BlockNumber(1:numel(BpodSystem.Data.Custom.ChoiceLeft)) == iBlock;
                if any(ndxBlock)
                    setStim = reshape(unique(OdorFracA(ndxBlock)),1,[]);
                    psyc = nan(size(setStim));
                    for iStim = setStim
                        ndxStim = reshape(OdorFracA == iStim,1,[]);
                        psyc(setStim==iStim) = sum(BpodSystem.Data.Custom.ChoiceLeft(ndxStim&~ndxNan&ndxBlock&ndxOlf))/...
                            sum(ndxStim&~ndxNan&ndxBlock&ndxOlf);
                    end
                    if iBlock <= numel(BpodSystem.GUIHandles.OutcomePlot.PsycOlf) && ishandle(BpodSystem.GUIHandles.OutcomePlot.PsycOlf(iBlock))
                        BpodSystem.GUIHandles.OutcomePlot.PsycOlf(iBlock).XData = setStim;
                        BpodSystem.GUIHandles.OutcomePlot.PsycOlf(iBlock).YData = psyc;
                        BpodSystem.GUIHandles.OutcomePlot.PsycOlfFit(iBlock).XData = linspace(min(setStim),max(setStim),100);
                        if sum(OdorFracA(ndxBlock&ndxOlf))>0
                            BpodSystem.GUIHandles.OutcomePlot.PsycOlfFit(iBlock).YData = glmval(glmfit(OdorFracA(ndxBlock&ndxOlf),...
                                BpodSystem.Data.Custom.ChoiceLeft(ndxBlock&ndxOlf)','binomial'),linspace(min(setStim),max(setStim),100),'logit');
                        end
                    else
                        lineColor = rgb2hsv([0.8314    0.5098    0.4157]);
                        bias = tanh(.3 * BpodSystem.Data.Custom.RewardMagnitude(find(ndxBlock,1),:) * [1 -1]');
                        lineColor(1) = 0.08+0.04*bias; lineColor(2) = .75; lineColor(3) = abs(bias); lineColor = hsv2rgb(lineColor);
                        %                     lineColor = lineColor + [0 0.3843*(tanh(BpodSystem.Data.Custom.RewardMagnitude(find(ndxBlock,1),:) * [1 -1]')) 0]
                        BpodSystem.GUIHandles.OutcomePlot.PsycOlf(iBlock) = line(AxesHandles.HandlePsycOlf,setStim,psyc, 'LineStyle','none','Marker','o',...
                            'MarkerEdge',lineColor,'MarkerFace',lineColor, 'MarkerSize',6);
                        BpodSystem.GUIHandles.OutcomePlot.PsycOlfFit(iBlock) = line(AxesHandles.HandlePsycOlf,[0 100],[.5 .5],'color',lineColor);
                    end
                end
                % GUIHandles.OutcomePlot.Psyc.YData = psyc;
            end
            %
            %
            %         stimSet = unique(OdorFracA);
            %         BpodSystem.GUIHandles.OutcomePlot.PsycOlf.XData = stimSet;
            %         psyc = nan(size(stimSet));
            %         for iStim = 1:numel(stimSet)
            %             ndxStim = OdorFracA == stimSet(iStim);
            %             ndxNan = isnan(BpodSystem.Data.Custom.ChoiceLeft(:));
            %             psyc(iStim) = nansum(BpodSystem.Data.Custom.ChoiceLeft(ndxStim)/sum(ndxStim&~ndxNan));
            %         end
            %         BpodSystem.GUIHandles.OutcomePlot.PsycOlf.YData = psyc;
        end
        
        %% Psych Aud
        if TaskParameters.GUI.ShowPsycAud
            AudDV = -BpodSystem.Data.Custom.DV(1:numel(BpodSystem.Data.Custom.ChoiceLeft));
            ndxAud = BpodSystem.Data.Custom.AuditoryTrial(1:numel(BpodSystem.Data.Custom.ChoiceLeft));
            ndxNan = isnan(BpodSystem.Data.Custom.ChoiceLeft);
            ChoiceRight = BpodSystem.Data.Custom.ChoiceLeft;
            ChoiceRight(ndxNan) = 1;
            ChoiceRight = ~ChoiceRight;
            AudBin = 8;
            BinIdx = discretize(AudDV,linspace(-1,1,AudBin+1));
            PsycY = grpstats(ChoiceRight(ndxAud&~ndxNan),BinIdx(ndxAud&~ndxNan),'mean');
            PsycX = unique(BinIdx(ndxAud&~ndxNan))/AudBin*2-1-1/AudBin;
            BpodSystem.GUIHandles.OutcomePlot.PsycAud.YData = PsycY;
            BpodSystem.GUIHandles.OutcomePlot.PsycAud.XData = PsycX;
            if sum(ndxAud&~ndxNan) > 1
                BpodSystem.GUIHandles.OutcomePlot.PsycAudFit.XData = linspace(min(AudDV),max(AudDV),100);
                BpodSystem.GUIHandles.OutcomePlot.PsycAudFit.YData = glmval(glmfit(AudDV(ndxAud&~ndxNan),...
                    ChoiceRight(ndxAud&~ndxNan)','binomial'),linspace(min(AudDV),max(AudDV),100),'logit');
            end
        end
        %% Vevaiometric
        if TaskParameters.GUI.ShowVevaiometric
            ndxError = BpodSystem.Data.Custom.ChoiceCorrect(1:iTrial) == 0 ; %all (completed) error trials (including catch errors)
            ndxCorrectCatch = BpodSystem.Data.Custom.CatchTrial(1:iTrial) & BpodSystem.Data.Custom.ChoiceCorrect(1:iTrial) == 1; %only correct catch trials
            ndxMinWT = BpodSystem.Data.Custom.FeedbackTime > TaskParameters.GUI.VevaiometricMinWT;
            DV = -BpodSystem.Data.Custom.DV(1:iTrial);
            DVNBin = TaskParameters.GUI.VevaiometricNBin;
            BinIdx = discretize(DV,linspace(-1,1,DVNBin+1));
            WTerr = grpstats(BpodSystem.Data.Custom.FeedbackTime(ndxError&ndxMinWT),BinIdx(ndxError&ndxMinWT),'mean')';
            WTcatch = grpstats(BpodSystem.Data.Custom.FeedbackTime(ndxCorrectCatch&ndxMinWT),BinIdx(ndxCorrectCatch&ndxMinWT),'mean')';
            Xerr = unique(BinIdx(ndxError&ndxMinWT))/DVNBin*2-1-1/DVNBin;
            Xcatch = unique(BinIdx(ndxCorrectCatch&ndxMinWT))/DVNBin*2-1-1/DVNBin;
            BpodSystem.GUIHandles.OutcomePlot.VevaiometricErr.YData = WTerr;
            BpodSystem.GUIHandles.OutcomePlot.VevaiometricErr.XData = Xerr;
            BpodSystem.GUIHandles.OutcomePlot.VevaiometricCatch.YData = WTcatch;
            BpodSystem.GUIHandles.OutcomePlot.VevaiometricCatch.XData = Xcatch;
            if TaskParameters.GUI.VevaiometricShowPoints
                BpodSystem.GUIHandles.OutcomePlot.VevaiometricPointsErr.YData = BpodSystem.Data.Custom.FeedbackTime(ndxError&ndxMinWT);
                BpodSystem.GUIHandles.OutcomePlot.VevaiometricPointsErr.XData = DV(ndxError&ndxMinWT);
                BpodSystem.GUIHandles.OutcomePlot.VevaiometricPointsCatch.YData = BpodSystem.Data.Custom.FeedbackTime(ndxCorrectCatch&ndxMinWT);
                BpodSystem.GUIHandles.OutcomePlot.VevaiometricPointsCatch.XData = DV(ndxCorrectCatch&ndxMinWT);
            else
                BpodSystem.GUIHandles.OutcomePlot.VevaiometricPointsErr.YData = -1;
                BpodSystem.GUIHandles.OutcomePlot.VevaiometricPointsErr.XData = 0;
                BpodSystem.GUIHandles.OutcomePlot.VevaiometricPointsCatch.YData = -1;
                BpodSystem.GUIHandles.OutcomePlot.VevaiometricPointsCatch.XData = 0;
            end
        end
        %% Trial rate
        if TaskParameters.GUI.ShowTrialRate
            BpodSystem.GUIHandles.OutcomePlot.TrialRate.XData = (BpodSystem.Data.TrialStartTimestamp-min(BpodSystem.Data.TrialStartTimestamp))/60;
            BpodSystem.GUIHandles.OutcomePlot.TrialRate.YData = 1:numel(BpodSystem.Data.Custom.ChoiceLeft);
        end
        if TaskParameters.GUI.ShowFix
            %% Stimulus delay
            cla(AxesHandles.HandleFix)
            BpodSystem.GUIHandles.OutcomePlot.HistBroke = histogram(AxesHandles.HandleFix,BpodSystem.Data.Custom.FixDur(BpodSystem.Data.Custom.FixBroke)*1000);
            BpodSystem.GUIHandles.OutcomePlot.HistBroke.BinWidth = 50;
            BpodSystem.GUIHandles.OutcomePlot.HistBroke.EdgeColor = 'none';
            BpodSystem.GUIHandles.OutcomePlot.HistBroke.FaceColor = 'r';
            BpodSystem.GUIHandles.OutcomePlot.HistFix = histogram(AxesHandles.HandleFix,BpodSystem.Data.Custom.FixDur(~BpodSystem.Data.Custom.FixBroke)*1000);
            BpodSystem.GUIHandles.OutcomePlot.HistFix.BinWidth = 50;
            BpodSystem.GUIHandles.OutcomePlot.HistFix.FaceColor = 'b';
            BpodSystem.GUIHandles.OutcomePlot.HistFix.EdgeColor = 'none';
            BreakP = mean(BpodSystem.Data.Custom.FixBroke);
            cornertext(AxesHandles.HandleFix,sprintf('P=%1.2f',BreakP))
        end
        %% ST
        if TaskParameters.GUI.ShowST
            cla(AxesHandles.HandleST)
            BpodSystem.GUIHandles.OutcomePlot.HistSTEarly = histogram(AxesHandles.HandleST,BpodSystem.Data.Custom.ST(BpodSystem.Data.Custom.EarlyWithdrawal)*1000);
            BpodSystem.GUIHandles.OutcomePlot.HistSTEarly.BinWidth = 50;
            BpodSystem.GUIHandles.OutcomePlot.HistSTEarly.FaceColor = 'r';
            BpodSystem.GUIHandles.OutcomePlot.HistSTEarly.EdgeColor = 'none';
            BpodSystem.GUIHandles.OutcomePlot.HistST = histogram(AxesHandles.HandleST,BpodSystem.Data.Custom.ST(~BpodSystem.Data.Custom.EarlyWithdrawal)*1000);
            BpodSystem.GUIHandles.OutcomePlot.HistST.BinWidth = 50;
            BpodSystem.GUIHandles.OutcomePlot.HistST.FaceColor = 'b';
            BpodSystem.GUIHandles.OutcomePlot.HistST.EdgeColor = 'none';
            EarlyP = sum(BpodSystem.Data.Custom.EarlyWithdrawal)/sum(~BpodSystem.Data.Custom.FixBroke);
            cornertext(AxesHandles.HandleST,sprintf('P=%1.2f',EarlyP))
        end
        %% Feedback delay (exclude catch trials and error trials, if set on catch)
        if TaskParameters.GUI.ShowFeedback
            cla(AxesHandles.HandleFeedback)
            if TaskParameters.GUI.CatchError
                ndxExclude = BpodSystem.Data.Custom.ChoiceCorrect(1:iTrial) == 0; %exclude error trials if they are set on catch
            else
                ndxExclude = false(1,iTrial);
            end
            BpodSystem.GUIHandles.OutcomePlot.HistNoFeed = histogram(AxesHandles.HandleFeedback,...
                                                                     BpodSystem.Data.Custom.FeedbackTime(~BpodSystem.Data.Custom.Feedback(1:iTrial)...
                                                                                                         &~BpodSystem.Data.Custom.CatchTrial(1:iTrial)...
                                                                                                         &~ndxExclude)*1000....
                                                                    );
            BpodSystem.GUIHandles.OutcomePlot.HistNoFeed.BinWidth = 100;
            BpodSystem.GUIHandles.OutcomePlot.HistNoFeed.EdgeColor = 'none';
            BpodSystem.GUIHandles.OutcomePlot.HistNoFeed.FaceColor = 'r';
            %BpodSystem.GUIHandles.OutcomePlot.HistNoFeed.Normalization = 'probability';
            BpodSystem.GUIHandles.OutcomePlot.HistFeed = histogram(AxesHandles.HandleFeedback,...
                                                                   BpodSystem.Data.Custom.FeedbackTime(BpodSystem.Data.Custom.Feedback(1:iTrial)...
                                                                                                       &~BpodSystem.Data.Custom.CatchTrial(1:iTrial)...
                                                                                                       &~ndxExclude)*1000....
                                                                   );
            BpodSystem.GUIHandles.OutcomePlot.HistFeed.BinWidth = 50;
            BpodSystem.GUIHandles.OutcomePlot.HistFeed.EdgeColor = 'none';
            BpodSystem.GUIHandles.OutcomePlot.HistFeed.FaceColor = 'b';
            %BpodSystem.GUIHandles.OutcomePlot.HistFeed.Normalization = 'probability';
            LeftSkip = sum(~BpodSystem.Data.Custom.Feedback(1:iTrial)&~BpodSystem.Data.Custom.CatchTrial(1:iTrial)&~ndxExclude&BpodSystem.Data.Custom.ChoiceLeft(1:iTrial)==1)/sum(~BpodSystem.Data.Custom.CatchTrial(1:iTrial)&~ndxExclude&BpodSystem.Data.Custom.ChoiceLeft(1:iTrial)==1);
            RightSkip = sum(~BpodSystem.Data.Custom.Feedback(1:iTrial)&~BpodSystem.Data.Custom.CatchTrial(1:iTrial)&~ndxExclude&BpodSystem.Data.Custom.ChoiceLeft(1:iTrial)==0)/sum(~BpodSystem.Data.Custom.CatchTrial(1:iTrial)&~ndxExclude&BpodSystem.Data.Custom.ChoiceLeft(1:iTrial)==0);
            cornertext(AxesHandles.HandleFeedback,{sprintf('L=%1.3f',LeftSkip),sprintf('R=%1.3f',RightSkip)})
        end
end

end

function [mn,mx] = rescaleX(AxesHandle,CurrentTrial,nTrialsToShow)
FractionWindowStickpoint = .75; % After this fraction of visible trials, the trial position in the window "sticks" and the window begins to slide through trials.
mn = max(round(CurrentTrial - FractionWindowStickpoint*nTrialsToShow),1);
mx = mn + nTrialsToShow - 1;
set(AxesHandle,'XLim',[mn-1 mx+1]);
end

function cornertext(h,str)
unit = get(h,'Units');
set(h,'Units','char');
pos = get(h,'Position');
if ~iscell(str)
    str = {str};
end
for i = 1:length(str)
    x = pos(1)+1;
    y = pos(2)+pos(4)-i;
    uicontrol(h.Parent,'Units','char','Position',[x,y,length(str{i})+1,1],'string',str{i},'style','text','background',[1,1,1],'FontSize',8);
end
set(h,'Units',unit);
end

