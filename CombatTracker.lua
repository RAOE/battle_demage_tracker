local start_time = 0
local end_time = 0
local total_time =0
local total_damage=0
local averange_dps= 0 
ChatFrame1:AddMessage("欢迎使用TrackerX！！")
function CombatTracker_OnEvent(frame, event, ...)
    if event == "PLAYER_REGEN_ENABLED" then 
        ChatFrame1:AddMessage("离开了战斗....")
        CombatTrackerFrameText:SetText("离开战斗...")
        end_time = GetTime()
        total_time = end_time - start_time
        averange_dps =total_damage /total_time
        CombatTracker_UpdateText()
    elseif event == "PLAYER_REGEN_DISABLED" then 
        CombatTrackerFrameText:SetText("进入战斗状态")
        total_damage = 0 
        start_time=GetTime()
    elseif event == "UNIT_COMBAT" then 
        local unit,action,modifier,damage,damagetype = ...
        if unit == "player" and action ~= "HEAL" then
          total_damage=total_damage+damage
          end_time = GetTime()
          total_time = end_time - start_time
          averange_dps =total_damage/total_time
          CombatTracker_UpdateText()
        end 
    end 
end
function CombatTracker_UpdateText()
   local status = string.format( "%d秒/ %d总量/ %.2f平均伤害值",total_time,total_damage,averange_dps)
   CombatTrackerFrameText:SetText(status)
end 
function CombatTracker_ReportDPS()
    local msgformat = "战斗时长%d 秒,受到了%d点伤害 .平均每秒受到的伤害:%.2f"
    local msg =string.format(msgformat,total_time,total_damage,averange_dps)
    ChatFrame1:AddMessage(tostring(msg))
    if GetNumPartyMembers()>0 then 
      SendChatMessage(msg,"PARTY")
    else 
      ChatFrame1:AddMessage(msg)
    end 
end 
function printMsg(msg)
  ChatFrame1:AddMessage(tostring(msg))
end 