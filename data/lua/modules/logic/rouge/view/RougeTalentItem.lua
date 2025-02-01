module("modules.logic.rouge.view.RougeTalentItem", package.seeall)

slot0 = class("RougeTalentItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._canvasGroup = slot0.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._txtDescr = gohelper.findChildText(slot0.viewGO, "txt_Descr")
	slot0._icon = gohelper.findChildImage(slot0.viewGO, "txt_Descr/go_Icon")
	slot0._iconlight = gohelper.findChild(slot0.viewGO, "txt_Descr/go_Icon/#light")
	slot0._boardImg = gohelper.findChildImage(slot0.viewGO, "go_Light")

	gohelper.setActive(slot0._boardImg, false)

	slot0._goSelected = slot0:_findChild("go_Selected", false)
	slot0._goConfirm = slot0:_findChild("go_Selected/image_Tick", true)
	slot0._goLineLight = slot0:_findChild("go_LineLight", false)
	slot0._goLineLight1 = slot0:_findChild("go_LineLight1", false)
	slot0._goLineLight2 = slot0:_findChild("go_LineLight2", false)
	slot0._goStar = slot0:_findChild("go_Star", false)
	slot0._goClick = slot0:_findChild("click", false)
	slot0.click = gohelper.getClickWithDefaultAudio(slot0._goClick)

	slot0.click:AddClickListener(slot0.onClick, slot0)

	slot0.clickConfirm = gohelper.getClickWithDefaultAudio(slot0._goSelected)

	slot0.clickConfirm:AddClickListener(slot0.onClickConfirm, slot0)

	slot0._goSelectedAnimator = slot0._goSelected:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.setState(slot0)
	slot1 = slot0._isSelected and slot0._talentState == RougeEnum.TalentState.CanActivated

	gohelper.setActive(slot0._goStar, false)
	gohelper.setActive(slot0._goSelected, slot1)
	gohelper.setActive(slot0._goClick, false)
	gohelper.setActive(slot0._boardImg, false)
	gohelper.setActive(slot0._goLineLight, false)
	gohelper.setActive(slot0._goLineLight1, false)
	gohelper.setActive(slot0._goLineLight2, false)

	if slot1 then
		slot0._goSelectedAnimator:Play("open", 0, 0)
	end

	if slot0._talentState == RougeEnum.TalentState.Disabled then
		slot2 = GameUtil.parseColor("#D3CCBF")
		slot2.a = 0.2
		slot0._txtDescr.color = slot2

		UISpriteSetMgr.instance:setRougeSprite(slot0._icon, "rouge_talent_point_01")
		gohelper.setActive(slot0._txtDescr, true)

		return
	end

	if slot0._talentState == RougeEnum.TalentState.CannotActivated then
		slot2 = GameUtil.parseColor("#D3CCBF")
		slot2.a = 0.2
		slot0._txtDescr.color = slot2

		UISpriteSetMgr.instance:setRougeSprite(slot0._icon, "rouge_talent_point_01")
		gohelper.setActive(slot0._txtDescr, true)
		gohelper.setActive(slot0._boardImg, true)

		slot3 = slot0._boardImg.color
		slot3.a = 0.4
		slot0._boardImg.color = slot3

		return
	end

	if slot0._talentState == RougeEnum.TalentState.CanActivated then
		slot2 = GameUtil.parseColor("#C5BEA1")
		slot2.a = 1
		slot0._txtDescr.color = slot2

		UISpriteSetMgr.instance:setRougeSprite(slot0._icon, "rouge_talent_point_02")
		gohelper.setActive(slot0._goStar, true)
		gohelper.setActive(slot0._goClick, true)
		gohelper.setActive(slot0._txtDescr, true)
		gohelper.setActive(slot0._boardImg, not slot1)

		slot3 = slot0._boardImg.color
		slot3.a = 1
		slot0._boardImg.color = slot3

		return
	end

	if slot0._talentState == RougeEnum.TalentState.Activated then
		gohelper.setActive(slot0._boardImg, false)

		slot2 = GameUtil.parseColor("#D3CCBF")
		slot2.a = 1
		slot0._txtDescr.color = slot2

		gohelper.setActive(slot0._txtDescr, true)
		gohelper.setActive(slot0._goStar, false)
		UISpriteSetMgr.instance:setRougeSprite(slot0._icon, slot0._isSpecial and "rouge_talent_point_04" or "rouge_talent_point_03")
		gohelper.setActive(slot0._goLineLight, true)
		gohelper.setActive(slot0._goLineLight1, true)
		gohelper.setActive(slot0._goLineLight2, true)

		if slot0._initState ~= slot0._talentState then
			gohelper.setActive(slot0._iconlight, true)
		end

		if slot0._isSelected then
			gohelper.setActive(slot0._goSelected, true)

			slot0._isSelected = false

			slot0._goSelectedAnimator:Play("close", 0, 0)
		end

		return
	end

	if slot0._talentState == RougeEnum.TalentState.SiblingActivated then
		gohelper.setActive(slot0._boardImg, false)
		gohelper.setActive(slot0._txtDescr, true)
		gohelper.setActive(slot0._goStar, false)

		slot0._txtDescr.text = ""

		UISpriteSetMgr.instance:setRougeSprite(slot0._icon, "rouge_talent_point_00")

		return
	end
end

function slot0.setSpecial(slot0, slot1)
	slot0._isSpecial = slot1
end

function slot0.setInfo(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0._talentView = slot1
	slot0._index = slot2
	slot0._sliblingComp = slot4
	slot0._prevGroupComp = slot5

	slot0:updateInfo(slot3)

	slot0._talentId = slot3.id
	slot0._talentConfig = lua_rouge_style_talent.configDict[slot0._talentId]
	slot0._txtDescr.text = slot0._talentConfig and slot0._talentConfig.desc
end

function slot0.updateInfo(slot0, slot1)
	slot0._talentMo = slot1
end

function slot0.isRootPlayCloseAnim(slot0)
	return slot0._oldTalentState == RougeEnum.TalentState.CanActivated and slot0._talentState == RougeEnum.TalentState.Activated
end

function slot0.isRootPlayOpenAnim(slot0)
	return slot0._oldTalentState == RougeEnum.TalentState.CannotActivated and slot0._talentState == RougeEnum.TalentState.CanActivated
end

function slot0.updateState(slot0, slot1)
	slot0._oldTalentState = slot0._talentState

	slot0:_checkState(slot1)

	if not slot0._initState then
		slot0._initState = slot0._talentState
	end

	slot0:setState()
end

function slot0._checkState(slot0, slot1)
	if slot0._talentMo.isActive == 1 then
		slot0._talentState = RougeEnum.TalentState.Activated

		return
	end

	if slot0._sliblingComp._talentMo.isActive == 1 then
		slot0._talentState = RougeEnum.TalentState.SiblingActivated

		return
	end

	if slot0:_parentGroupIsActive() and slot1 then
		slot0._talentState = RougeEnum.TalentState.CanActivated

		return
	end

	if slot1 then
		slot0._talentState = RougeEnum.TalentState.CannotActivated

		return
	end

	slot0._talentState = RougeEnum.TalentState.Disabled
end

function slot0.canActivated(slot0)
	return slot0._talentState == RougeEnum.TalentState.CanActivated
end

function slot0.needCostTalentPoint(slot0)
	return slot0._talentState == RougeEnum.TalentState.CanActivated or slot0._talentState == RougeEnum.TalentState.CannotActivated
end

function slot0._parentGroupIsActive(slot0)
	if not slot0._prevGroupComp then
		return true
	end

	for slot4, slot5 in ipairs(slot0._prevGroupComp) do
		if slot5._talentMo.isActive == 1 then
			return true
		end
	end

	return false
end

function slot0.onClick(slot0)
	if slot0._isSelected then
		return
	end

	slot0._talentView:setTalentCompSelected(slot0)
end

function slot0.setSelected(slot0, slot1)
	slot0._isSelected = slot1

	slot0:setState()
end

function slot0.onClickConfirm(slot0)
	if slot0._talentState == RougeEnum.TalentState.Activated then
		return
	end

	slot0._goSelectedAnimator:Play("close", 0, 0)
	slot0._talentView:activeTalent(slot0)
end

function slot0._findChild(slot0, slot1, slot2)
	slot3 = gohelper.findChild(slot0.viewGO, slot1)

	gohelper.setActive(slot3, slot2)

	return slot3
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
end

function slot0.onDestroyView(slot0)
	slot0.click:RemoveClickListener()
	slot0.clickConfirm:RemoveClickListener()
end

return slot0
