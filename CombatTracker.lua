local start_time = 0
local end_time = 0
local total_time =0
local total_damage=0
local averange_dps= 0 
local player_damage= 0
local player_averange_dps=0
local player_health=0
ChatFrame1:AddMessage("欢迎使用TrackerX！！")
player_health = UnitHealth("player")
function CombatTracker_OnEvent(frame, event, ...)
    printMsg(UNIT_MAXPOWER("player"))
    if event == "PLAYER_REGEN_ENABLED" then 
        ChatFrame1:AddMessage("离开战斗")
        CombatTrackerFrameText:SetText("[伤害统计插件]by九幽")
        CombatTracker_ReportDPS()
        end_time = GetTime()
        total_time = end_time - start_time
        averange_dps =total_damage /total_timeatttwt
        player_averange_dps = player_damage/total_time
        CombatTracker_UpdateText()
    elseif event == "PLAYER_REGEN_DISABLED" then 
        CombatTrackerFrameText:SetText("进入战斗状态")
        total_damage = 0 
        start_time=GetTime()
    elseif event == "UNIT_COMBAT" then 
        local unit,action,modifier,damage,damagetype= ...
        if unit == "player" and action ~= "HEAL" then
          total_damage=total_damage+damage
          end_time = GetTime()
          total_time = end_time - start_time
          averange_dps =total_damage/total_time
          printMsg(UnitHealth("player"))
          printMsg(UnitName("player"))
          printMsg(UnitSex("player"))
          if UnitHealth("player") < player_health * 0.5 then 
            ChatFrame1:AddMessage("当前生命值过低,请使用恢复药剂  请使用强效治疗药剂")
          end 
        end 
        if unit =="target" and action ~= "HEAL" then 
          player_damage = player_damage+damage
        end
        CombatTracker_UpdateText()
    end  
end
function CombatTracker_UpdateText()
   local status = string.format( "%d总量/ %d总量2/ %d秒/ %.2f平均伤害值1 /%.2f平均伤害值2",player_damage,total_damage,total_time,averange_dps,player_averange_dps)
   CombatTrackerFrameText:SetText(status)
end 
function CombatTracker_ReportDPS()
    local msgformat = "战斗时长%d 秒,受到了%d点伤害 .平均每秒受到的伤害:%.2f,玩家造成了 %d 点伤害"
    local msg =string.format(msgformat,total_time,total_damage,averange_dps,player_damage)
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