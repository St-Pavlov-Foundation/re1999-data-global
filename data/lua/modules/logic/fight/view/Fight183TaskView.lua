module("modules.logic.fight.view.Fight183TaskView", package.seeall)

slot0 = class("Fight183TaskView", FightBaseView)

function slot0.onInitView(slot0)
	slot0._titleText = gohelper.findChildText(slot0.viewGO, "#txt_title")
	slot0._descText = gohelper.findChildText(slot0.viewGO, "#txt_dec")
end

function slot0.addEvents(slot0)
	slot0:com_registFightEvent(FightEvent.OnBuffUpdate, slot0._onBuffUpdate)
end

function slot0.removeEvents(slot0)
end

function slot0.onConstructor(slot0, slot1)
	slot0._config = lua_challenge_condition.configDict[string.splitToNumber(slot1, "#")[1]]
end

function slot0.onOpen(slot0)
	slot0:_refreshData()
end

function slot0._onBuffUpdate(slot0, slot1, slot2, slot3)
	if not slot0._config then
		return
	end

	if slot1 ~= FightEntityScene.MySideId then
		return
	end

	slot0:_refreshData()
end

function slot0._refreshData(slot0)
	if slot0._config then
		slot2 = false

		if slot0._config.type == 19 then
			slot3 = tonumber(slot1.value)

			if FightDataHelper.entityMgr:getMyVertin() then
				for slot8, slot9 in pairs(slot4.buffDic) do
					if slot9.buffId == slot3 then
						slot2 = true

						break
					end
				end
			end
		end

		slot3 = ""

		if slot2 then
			slot3 = string.format("<color=#7A8E51>%s</color>", luaLang("act183task_condition_title_complete"))
			slot4 = string.format("<s><color=#7A8E51>%s</color></s>", slot1.decs1)
		else
			slot3 = luaLang("act183task_condition_title")
		end

		slot0._titleText.text = slot3
		slot0._descText.text = slot4
	else
		slot0._titleText.text = ""
		slot0._descText.text = ""
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
