module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotInteractChoiceItem", package.seeall)

slot0 = class("V1a6_CachotInteractChoiceItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._gonormal = gohelper.findChild(slot1, "normal")
	slot0._goselect = gohelper.findChild(slot1, "select")
	slot0._golock = gohelper.findChild(slot1, "locked")
	slot0._clickNormal = gohelper.findChildButtonWithAudio(slot1, "normal/click")
	slot0._clickSelect = gohelper.findChildButtonWithAudio(slot1, "select/click")
	slot0._clickLock = gohelper.findChildButtonWithAudio(slot1, "locked/click")
	slot0._txtnormaltitle = gohelper.findChildTextMesh(slot1, "normal/layout/#txt_info1")
	slot0._txtnormaldesc = gohelper.findChildTextMesh(slot1, "normal/layout/#txt_info2")
	slot0._txtnormalinfo = gohelper.findChildTextMesh(slot1, "normal/layout/tipsbg/#txt_tips")
	slot0._gonormallockIcon = gohelper.findChild(slot1, "normal/#txt_tips/icon")
	slot0._txtselecttitle = gohelper.findChildTextMesh(slot1, "select/layout/info1")
	slot0._txtselectdesc = gohelper.findChildTextMesh(slot1, "select/layout/info2")
	slot0._txtselectinfo = gohelper.findChildTextMesh(slot1, "select/layout/tips")
	slot0._txtlocktitle = gohelper.findChildTextMesh(slot1, "locked/layout/#txt_info1")
	slot0._txtlockdesc = gohelper.findChildTextMesh(slot1, "locked/layout/#txt_info2")
	slot0._txtlockinfo = gohelper.findChildTextMesh(slot1, "locked/layout/tipsbg/#txt_tips")
	slot0._anim = slot1:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.addEventListeners(slot0)
	slot0._clickNormal:AddClickListener(slot0._selectThis, slot0)
	slot0._clickSelect:AddClickListener(slot0._selectChoice, slot0)
	slot0._clickLock:AddClickListener(slot0._selectThis, slot0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.SelectChoice, slot0._onChoiceSelect, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._clickNormal:RemoveClickListener()
	slot0._clickSelect:RemoveClickListener()
	slot0._clickLock:RemoveClickListener()
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.SelectChoice, slot0._onChoiceSelect, slot0)
end

function slot0._playOpenAnim(slot0)
	slot0._anim:Play("open")
	UIBlockMgr.instance:endBlock("V1a6_CachotInteractChoiceItem_close")
end

function slot0.updateMo(slot0, slot1, slot2)
	if slot0._co then
		slot0._anim:Play("unselect", 0, 1)
		slot0._anim:Update(0)
	end

	if V1a6_CachotRoomModel.instance.isFromDramaToDrama then
		UIBlockMgr.instance:startBlock("V1a6_CachotInteractChoiceItem_close")
		slot0._anim:Play("close")
		TaskDispatcher.runDelay(slot0._playOpenAnim, slot0, 0.167)
	end

	slot0._co = slot1
	slot0._index = slot2
	slot0._txtnormaltitle.text = slot0._co.title
	slot0._txtselecttitle.text = slot0._co.title
	slot0._txtlocktitle.text = slot0._co.title
	slot0._txtnormaldesc.text = slot0._co.desc
	slot0._txtselectdesc.text = slot0._co.desc
	slot0._txtlockdesc.text = slot0._co.desc
	slot0._txtnormalinfo.text = ""
	slot0._txtselectinfo.text = ""
	slot0._txtlockinfo.text = ""

	slot0:_setIsSelect(false, true)

	slot0._lockDesInfo = nil

	if not string.nilorempty(slot1.condition) then
		slot0._lockDesInfo = {
			V1a6_CachotChoiceConditionHelper.getConditionToast(unpack(string.splitToNumber(slot1.condition, "#")))
		}

		if not slot0._lockDesInfo[1] then
			slot0._lockDesInfo = nil
		end
	end

	if slot0._lockDesInfo then
		slot0._txtlockinfo.text = slot0:_formatStr(lua_toast.configDict[slot0._lockDesInfo[1]].tips, unpack(slot0._lockDesInfo, 2))

		gohelper.setActive(slot0._golock, true)
		gohelper.setActive(slot0._gonormal, false)
		gohelper.setActive(slot0._goselect, false)

		return
	end

	gohelper.setActive(slot0._golock, false)
	gohelper.setActive(slot0._gonormal, true)
	gohelper.setActive(slot0._goselect, true)

	if slot1.collection > 0 then
		if lua_rogue_collection.configDict[slot1.collection] then
			slot0._txtselectinfo.text = V1a6_CachotCollectionConfig.instance:getCollectionSkillsContent(slot3)
		else
			logError("没有藏品配置" .. slot1.collection)
		end
	elseif lua_rogue_event.configDict[slot1.event] and slot3.type == V1a6_CachotEnum.EventType.CharacterRebirth then
		slot5 = 0

		if V1a6_CachotModel.instance:getTeamInfo() then
			for slot9, slot10 in ipairs(slot4.lifes) do
				if slot10.lifePercent <= 0 then
					slot5 = slot5 + 1
				end
			end
		end

		slot6 = formatLuaLang("cachot_death_count", slot5)
		slot0._txtnormalinfo.text = slot6
		slot0._txtselectinfo.text = slot6
	end
end

function slot0._formatStr(slot0, slot1, ...)
	if not ... then
		return slot1
	end

	for slot6, slot7 in ipairs({
		...
	}) do
		slot1 = slot1:gsub("▩" .. slot6 .. "%%s", slot7)
	end

	return slot1
end

function slot0._selectThis(slot0)
	if slot0._lockDesInfo then
		GameFacade.showToast(unpack(slot0._lockDesInfo))

		return
	end

	slot0:_setIsSelect(true)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.SelectChoice, slot0._index)
end

function slot0._setIsSelect(slot0, slot1, slot2)
	gohelper.setActive(slot0._clickNormal, not slot1)
	gohelper.setActive(slot0._clickSelect, slot1)

	if not slot2 and not slot0._lockDesInfo and slot0._isSelect ~= slot1 then
		if slot1 then
			slot0._anim:Play("select")
		else
			slot0._anim:Play("unselect")
		end
	end

	slot0._isSelect = slot1
end

function slot0._onChoiceSelect(slot0, slot1)
	if slot1 ~= slot0._index then
		slot0:_setIsSelect(false)
	end
end

function slot0._selectChoice(slot0)
	if not V1a6_CachotRoomModel.instance:getNowTopEventMo() then
		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.PlayChoiceDialog, slot0._co.dialogId)
		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.ShowHideChoice, false)
		logError("没有进行中的事件？？？？？")

		return
	end

	RogueRpc.instance:sendRogueEventSelectRequest(V1a6_CachotEnum.ActivityId, slot1.eventId, slot0._co.id, slot0._onSelectEnd, slot0)
end

function slot0._onSelectEnd(slot0)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.PlayChoiceDialog, slot0._co.dialogId)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.ShowHideChoice, false)
end

function slot0.onDestroy(slot0)
	UIBlockMgr.instance:endBlock("V1a6_CachotInteractChoiceItem_close")
	TaskDispatcher.cancelTask(slot0._playOpenAnim, slot0)
end

return slot0
