local start_time = 0
local end_time = 0
local total_time =0
local total_damage=0
local averange_dps= 0 
ChatFrame1:AddMessage("欢迎使用CombatTracker！！")
function CombatTracker_OnEvent(frame,event)
    ChatFrame1:AddMessage("ON_EVENT被触发了")
    ChatFrame1:AddMessage(tostring(event))
    if event == "PLAYER_REGEN_ENABLED" then 
        ChatFrame1:AddMessage("离开了战斗....")
        CombatTrackerFrameText:SetText("离开战斗...")
        end_time = GetTime()
        total_time = end_time - start_time
        averange_dps =total_damage /total_time
        CombatTracker_UpdateText()
    elseif event == "PLAYER_REGEN_DISABLED" then 
        ChatFrame1:AddMessage("im combat ...")
        CombatTrackerFrameText:SetText("战斗状态")
        total_damage = 0 
        start_time=GetTime() 
    end 
end
function CombatTracker_UpdateText()
   local status = string.format( "%ds /d dmg /%.2f dps",total_time,total_damage,averange_dps)
   CombatTrackerFrameText:SetText(status)
end 
function CombatTracker_ReportDPS()
    ChatFrame1:AddMessage("load... CombatTracker_ReportDPS");
    local msgformat = "%d seconds spent in combat with %d incoming damage .Average incoming DSP was %.2f"
    local msg =string.format(msgformat,total_time,total_damage,averange_dps)
    ChatFrame1:AddMessage(tostring(msg));
    if GetNumPartyMembers()>0 then 
      SendChatMessage(msg,"PARTY")
    else 
      ChatFrame1:AddMessage(msg)
    end 
end 
