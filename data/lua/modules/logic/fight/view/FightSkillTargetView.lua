module("modules.logic.fight.view.FightSkillTargetView", package.seeall)

slot0 = class("FightSkillTargetView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._groupGO = gohelper.findChild(slot0.viewGO, "group")
	slot0._txtDesc = gohelper.findChildText(slot0.viewGO, "#txt_desc")
	slot0._itemList = {}
	slot0._targetLimit = nil
end

function slot0.addEvents(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.SimulateSelectSkillTargetInView, slot0._simulateSelect, slot0)
end

function slot0.removeEvents(slot0)
	slot4 = FightController.instance

	slot0:removeEventCb(slot4, FightEvent.SimulateSelectSkillTargetInView, slot0._simulateSelect, slot0)

	for slot4 = 1, #slot0._itemList do
		gohelper.getClick(slot0._itemList[slot4].go):RemoveClickListener()
	end
end

function slot0.onOpen(slot0)
	PostProcessingMgr.instance:setBlurWeight(1)
	slot0._simagebg:LoadImage(ResUrl.getFightSkillTargetcIcon("full/zhandouxuanzedi_007"))

	slot0._targetLimit = slot0.viewParam.targetLimit

	if slot0.viewParam.desc then
		slot0._txtDesc.text = slot0.viewParam.desc
	else
		slot0._txtDesc.text = luaLang("select_skill_target")
	end

	if not slot0._targetLimit then
		slot0._targetLimit = {}
		slot6 = slot0.viewParam.fromId

		for slot6, slot7 in ipairs(FightHelper.getTargetLimits(FightEnum.EntitySide.MySide, slot0.viewParam.skillId, slot6)) do
			if FightDataHelper.entityMgr:getById(slot7).entityType == 3 then
				-- Nothing
			elseif not slot8:hasBuffFeature(FightEnum.BuffType_CantSelect) then
				if slot8:hasBuffFeature(FightEnum.BuffType_CantSelectEx) then
					-- Nothing
				elseif DungeonModel.instance.curSendChapterId ~= DungeonEnum.ChapterId.RoleDuDuGu or slot8.originSkin ~= CharacterEnum.DefaultSkinId.DuDuGu then
					table.insert(slot0._targetLimit, slot7)
				end
			end
		end
	end

	table.sort(slot0._targetLimit, uv0._sortByStandPos)

	for slot5, slot6 in ipairs(slot0._targetLimit) do
		if not slot0._itemList[slot5] then
			slot7 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._groupGO, "item" .. slot5), FightSkillTargetItem)

			table.insert(slot0._itemList, slot7)
			gohelper.getClick(slot7.go):AddClickListener(slot0._onClickItem, slot0, slot5)
		end

		gohelper.setActive(slot7.go, true)
		slot7:onUpdateMO(slot6)
	end

	for slot5 = #slot0._targetLimit + 1, #slot0._itemList do
		gohelper.setActive(slot0._itemList[slot5].go, false)
	end

	if slot0.viewParam.mustSelect then
		slot0._mustSelect = true

		NavigateMgr.instance:addEscape(slot0.viewContainer.viewName, slot0._onBtnEsc, slot0)
	end
end

function slot0._onBtnEsc(slot0)
end

function slot0._sortByStandPos(slot0, slot1)
	slot3 = FightDataHelper.entityMgr:getById(slot1)

	if FightDataHelper.entityMgr:getById(slot0) and slot3 then
		return math.abs(slot2.position) < math.abs(slot3.position)
	else
		return math.abs(tonumber(slot0)) < math.abs(tonumber(slot1))
	end
end

function slot0._onClickItem(slot0, slot1)
	slot0:closeThis()

	if slot0.viewParam.callbackObj then
		slot0.viewParam.callback(slot4, slot0._targetLimit[slot1])
	else
		slot3(slot2)
	end
end

function slot0.onClose(slot0)
	slot0._simagebg:UnLoadImage()
	PostProcessingMgr.instance:setBlurWeight(0)
end

function slot0.onClickModalMask(slot0)
	if slot0._mustSelect then
		return
	end

	slot0:closeThis()
end

function slot0._simulateSelect(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._targetLimit) do
		if slot6 == slot1 then
			slot0:_onClickItem(slot5)

			return
		end
	end

	slot0:_onClickItem(1)
	logError("模拟选中entity失败，不存在的entityId = " .. slot1 .. "，只有：" .. cjson.encode(slot0._targetLimit))
end

return slot0
