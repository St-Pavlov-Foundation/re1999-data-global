module("modules.logic.fight.view.FightNaNaTargetView", package.seeall)

slot0 = class("FightNaNaTargetView", BaseView)

function slot0.onInitView(slot0)
	slot0._goUnSelected = gohelper.findChild(slot0.viewGO, "#go_UnSelected")
	slot0._goSelected = gohelper.findChild(slot0.viewGO, "#go_Selected")
	slot0._goItemGroup = gohelper.findChild(slot0.viewGO, "#go_itemgroup")
	slot0._txtSkillName = gohelper.findChildText(slot0.viewGO, "#go_Selected/#txt_SkillName")
	slot0._txtSkillDescr = gohelper.findChildText(slot0.viewGO, "#go_Selected/#txt_SkillDescr")
	slot0._btnSign = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Sign")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnSign:AddClickListener(slot0._btnSignOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnSign:RemoveClickListener()
end

function slot0._btnSignOnClick(slot0)
	if slot0.curSelectEntity == 0 then
		return
	end

	AudioMgr.instance:trigger(20220174)
	FightRpc.instance:sendUseClothSkillRequest(0, slot0.nanaEntityId, slot0.curSelectEntity, FightEnum.ClothSkillType.Contract)
end

function slot0._editableInitView(slot0)
	slot0.goBtnSign = slot0._btnSign.gameObject

	gohelper.setActive(slot0.goBtnSign, false)

	slot0.itemPrefab = slot0.viewContainer:getRes(slot0.viewContainer:getSetting().otherRes[1])
	slot0.itemList = {}

	slot0:initCareerBindBuff()
	NavigateMgr.instance:addEscape(slot0.viewName, slot0.blockEsc)
	slot0:addEventCb(FightController.instance, FightEvent.StartPlayClothSkill, slot0.onStartPlayClothSkill, slot0, LuaEventSystem.High)
	slot0:addEventCb(FightController.instance, FightEvent.RespUseClothSkillFail, slot0.closeThis, slot0, LuaEventSystem.High)
end

function slot0.blockEsc()
end

function slot0.onStartPlayClothSkill(slot0)
	slot0:closeThis()
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(20220172)

	slot0.curSelectEntity = 0
	slot0.entityIdList = FightModel.instance.canContractList
	slot0.nanaEntityId = FightModel.instance.notifyEntityId
	slot0.nanaExSkillLv = FightDataHelper.entityMgr:getById(slot0.nanaEntityId) and slot1.exSkillLevel or 0

	table.sort(slot0.entityIdList, uv0.sortEntityId)

	for slot5, slot6 in ipairs(slot0.entityIdList) do
		slot0:addItem(slot6)
	end

	slot0:refreshSelect()
	FightModel.instance:setNotifyContractInfo(nil, )
end

function slot0.sortEntityId(slot0, slot1)
	if not FightDataHelper.entityMgr:getById(slot0) then
		return false
	end

	if not FightDataHelper.entityMgr:getById(slot1) then
		return false
	end

	return slot2.position < slot3.position
end

function slot0.initCareerBindBuff(slot0)
	slot0.careerDict = {}

	for slot6, slot7 in ipairs(FightStrUtil.instance:getSplitCache(lua_fight_const.configDict[31].value, "|")) do
		slot8 = string.split(slot7, "%")
		slot9 = tonumber(slot8[1])
		slot13 = ","

		for slot13, slot14 in ipairs(string.split(slot8[2], slot13)) do
			slot15 = string.splitToNumber(slot14, ":")
			slot17 = slot15[2]

			if not slot0.careerDict[slot15[1]] then
				slot0.careerDict[slot16] = {}
			end

			slot18[slot9] = slot17
		end
	end
end

function slot0.addItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = gohelper.clone(slot0.itemPrefab, slot0._goItemGroup)
	slot2.goSelect = gohelper.findChild(slot2.go, "#go_SelectedFrame")
	slot2.simageIcon = gohelper.findChildSingleImage(slot2.go, "icon")
	slot2.imageCareer = gohelper.findChildImage(slot2.go, "#image_Attr")

	if FightDataHelper.entityMgr:getById(slot1) then
		slot2.simageIcon:LoadImage(ResUrl.getHeadIconSmall(FightConfig.instance:getSkinCO(slot3.skin) and slot4.retangleIcon))
	end

	UISpriteSetMgr.instance:setCommonSprite(slot2.imageCareer, "lssx_" .. slot3.career)

	slot2.uid = slot1
	slot2.click = gohelper.getClickWithDefaultAudio(slot2.go)

	slot2.click:AddClickListener(slot0.onClickItem, slot0, slot1)
	table.insert(slot0.itemList, slot2)
end

function slot0.onClickItem(slot0, slot1)
	if slot1 == slot0.curSelectEntity then
		return
	end

	AudioMgr.instance:trigger(20220173)

	slot0.curSelectEntity = slot1

	slot0:refreshSelect()
end

function slot0.refreshSelect(slot0)
	gohelper.setActive(slot0.goBtnSign, slot0.curSelectEntity ~= 0)
	slot0:refreshSelectStatus()
	slot0:refreshSelectText()
end

function slot0.refreshSelectStatus(slot0)
	for slot4, slot5 in ipairs(slot0.itemList) do
		gohelper.setActive(slot5.goSelect, slot5.uid == slot0.curSelectEntity)
	end
end

function slot0.refreshSelectText(slot0)
	slot1 = slot0.curSelectEntity ~= 0

	gohelper.setActive(slot0._goSelected, slot1)
	gohelper.setActive(slot0._goUnSelected, not slot1)

	if slot1 then
		slot0:refreshBuffText()
	end
end

function slot0.refreshBuffText(slot0)
	if not FightDataHelper.entityMgr:getById(slot0.curSelectEntity) then
		logError("没找到entityMo : " .. tostring(slot0.curSelectEntity))

		return
	end

	slot4 = slot1.career and (slot0.careerDict[slot0.nanaExSkillLv] or slot0.careerDict[0])[slot3]

	if not (slot4 and lua_skill_buff.configDict[slot4]) then
		logError("没找到buffCo : " .. tostring(slot4))

		return
	end

	slot0._txtSkillName.text = slot5.name
	slot0._txtSkillDescr.text = slot5.desc
end

function slot0.onClose(slot0)
	FightDataHelper.stageMgr:exitOperateState(FightStageMgr.OperateStateType.BindContract)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0.itemList) do
		slot5.simageIcon:UnLoadImage()
		slot5.click:RemoveClickListener()
	end

	slot0.itemList = nil
end

return slot0
