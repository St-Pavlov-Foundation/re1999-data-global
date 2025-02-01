module("modules.logic.equip.view.EquipCareerListView", package.seeall)

slot0 = class("EquipCareerListView", UserDataDispose)

function slot0.onInitView(slot0, slot1, slot2, slot3)
	slot0:__onInit()

	slot0.careerGoDrop = slot1
	slot0.careerDropClick = gohelper.findChildClick(slot0.careerGoDrop, "clickArea")
	slot0.careerGoTemplateContainer = gohelper.findChild(slot0.careerGoDrop, "Template")
	slot0.careerGoItem = gohelper.findChild(slot0.careerGoDrop, "Template/Viewport/Content/Item")
	slot0.txtLabel = gohelper.findChildText(slot0.careerGoDrop, "Label")
	slot0.iconLabel = gohelper.findChildImage(slot0.careerGoDrop, "Icon")

	gohelper.setActive(slot0.careerGoItem, false)
	slot0.careerDropClick:AddClickListener(slot0.onCareerDropClick, slot0)

	slot0.showingTemplateContainer = false
	slot0.careerItemList = {}
	slot0.itemCallback = slot2
	slot0.itemCallbackObj = slot3
	slot0.rectList = {}

	slot0:initMoData()
	slot0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreen, slot0._onTouch, slot0)
end

function slot0.initMoData(slot0)
	slot0.careerValueList = {
		EquipHelper.CareerValue.All,
		EquipHelper.CareerValue.Rock,
		EquipHelper.CareerValue.Star,
		EquipHelper.CareerValue.Wood,
		EquipHelper.CareerValue.Animal,
		EquipHelper.CareerValue.SAW
	}
	slot0.careerMoList = {}
	slot0.careerMoDict = {}
	slot1 = {
		txt = luaLang("common_all"),
		iconName = nil,
		career = slot0.careerValueList[1]
	}
	slot0.careerMoDict[slot0.careerValueList[1]] = slot1

	table.insert(slot0.careerMoList, slot1)

	for slot5 = 2, 6 do
		slot1 = {
			txt = nil,
			iconName = "career_" .. slot0.careerValueList[slot5],
			career = slot0.careerValueList[slot5]
		}
		slot0.careerMoDict[slot0.careerValueList[slot5]] = slot1

		table.insert(slot0.careerMoList, slot1)
	end
end

function slot0.onCareerDropClick(slot0)
	slot0.showingTemplateContainer = not slot0.showingTemplateContainer

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_admission_open)
	gohelper.setActive(slot0.careerGoTemplateContainer, slot0.showingTemplateContainer)
	gohelper.setAsLastSibling(slot0.careerGoTemplateContainer)
end

function slot0.onCareerItemClick(slot0, slot1)
	slot0:setSelectCareer(slot1.career)
	slot0:refreshCareerLabel()
	slot0:refreshCareerSelect()

	slot0.showingTemplateContainer = false

	gohelper.setActive(slot0.careerGoTemplateContainer, false)

	if slot0.itemCallback then
		if slot0.itemCallbackObj then
			slot0.itemCallback(slot0.itemCallbackObj, slot1)
		else
			slot0.itemCallback(slot1)
		end
	end
end

function slot0.initTouchRectList(slot0)
	table.insert(slot0.rectList, slot0:getRectTransformTouchRect(slot0.careerDropClick.transform))
	table.insert(slot0.rectList, slot0:getRectTransformTouchRect(slot0.careerGoTemplateContainer.transform))
end

function slot0.getRectTransformTouchRect(slot0, slot1)
	slot2 = slot1:GetWorldCorners()
	slot3 = CameraMgr.instance:getUICamera()

	return {
		slot3:WorldToScreenPoint(slot2[0]),
		slot3:WorldToScreenPoint(slot2[1]),
		slot3:WorldToScreenPoint(slot2[2]),
		slot3:WorldToScreenPoint(slot2[3])
	}
end

function slot0._onTouch(slot0)
	if not next(slot0.rectList) then
		logWarn("touch area not init")

		return
	end

	for slot5, slot6 in ipairs(slot0.rectList) do
		if GameUtil.checkPointInRectangle(GamepadController.instance:getMousePosition(), slot6[1], slot6[2], slot6[3], slot6[4]) then
			return
		end
	end

	slot0.showingTemplateContainer = false

	gohelper.setActive(slot0.careerGoTemplateContainer, false)
end

function slot0.getCareerMoList(slot0)
	return slot0.careerMoList
end

function slot0.setSelectCareer(slot0, slot1)
	slot0.selectCareer = slot1
end

function slot0.getSelectCareer(slot0)
	return slot0.selectCareer or EquipHelper.CareerValue.All
end

function slot0.getSelectCareerMo(slot0)
	return slot0.careerMoDict[slot0:getSelectCareer()]
end

function slot0.refreshCareerSelect(slot0)
	for slot4, slot5 in ipairs(slot0.careerItemList) do
		slot5:refreshSelect(slot0:getSelectCareer())
	end
end

function slot0.refreshCareerLabel(slot0)
	if not slot0:getSelectCareerMo() then
		logError("not set selected career, please check code!")

		return
	end

	if slot1.txt then
		slot0.txtLabel.text = slot1.txt

		gohelper.setActive(slot0.txtLabel.gameObject, true)
	else
		gohelper.setActive(slot0.txtLabel.gameObject, false)
	end

	if slot1.iconName then
		UISpriteSetMgr.instance:setCommonSprite(slot0.iconLabel, slot1.iconName)
		gohelper.setActive(slot0.iconLabel.gameObject, true)
	else
		gohelper.setActive(slot0.iconLabel.gameObject, false)
	end
end

function slot0.onOpen(slot0)
	slot0:setSelectCareer(EquipHelper.CareerValue.All)

	slot1 = nil

	for slot5, slot6 in ipairs(slot0.careerMoList) do
		slot1 = EquipCareerItem.New()

		slot1:onInitView(gohelper.cloneInPlace(slot0.careerGoItem, "career_" .. slot6.career), slot0.onCareerItemClick, slot0)
		slot1:onUpdateMO(slot6)
		table.insert(slot0.careerItemList, slot1)
	end

	slot0:initTouchRectList()
	slot0:refreshCareerSelect()
	slot0:refreshCareerLabel()
end

function slot0.onDestroyView(slot0)
	slot0.careerDropClick:RemoveClickListener()

	for slot4, slot5 in ipairs(slot0.careerItemList) do
		slot5:onDestroyView()
	end

	slot0.careerItemList = nil
	slot0.careerMoList = nil
	slot0.careerMoDict = nil

	slot0:__onDispose()
end

return slot0
