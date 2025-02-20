module("modules.logic.equip.view.EquipTeamView", package.seeall)

slot0 = class("EquipTeamView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebgmask = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bgmask")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._goequipcontainer = gohelper.findChild(slot0.viewGO, "#go_equipcontainer")
	slot0._scrollequip = gohelper.findChildScrollRect(slot0.viewGO, "#go_equipcontainer/#scroll_equip")
	slot0._goequipsort = gohelper.findChild(slot0.viewGO, "#go_equipcontainer/#go_equipsort")
	slot0._btnequiplv = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiplv")
	slot0._btnequiprare = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiprare")
	slot0._simagenoequiptip = gohelper.findChildSingleImage(slot0.viewGO, "#simage_noequiptip")
	slot0._goroletags = gohelper.findChild(slot0.viewGO, "tags/#go_roletags")
	slot0._goposlist = gohelper.findChild(slot0.viewGO, "tags/#go_poslist")
	slot0._gostorytag = gohelper.findChild(slot0.viewGO, "tags/#go_roletags/#go_storytag")
	slot0._goaidtag = gohelper.findChild(slot0.viewGO, "tags/#go_roletags/#go_aidtag")
	slot0._goskillpos = gohelper.findChild(slot0.viewGO, "#go_skillpos")
	slot0._goTouchArea = gohelper.findChild(slot0.viewGO, "#go_touchArea")
	slot0._simageblurmask = gohelper.findChildSingleImage(slot0.viewGO, "#simage_blurmask")
	slot0._viewAnim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._simagemask = gohelper.findChildSingleImage(slot0.viewGO, "#simage_mask")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnequiplv:AddClickListener(slot0._btnequiplvOnClick, slot0)
	slot0._btnequiprare:AddClickListener(slot0._btnequiprareOnClick, slot0)
	slot0._slide:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._slide:AddDragEndListener(slot0._onDragEnd, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnequiplv:RemoveClickListener()
	slot0._btnequiprare:RemoveClickListener()
	slot0._slide:RemoveDragBeginListener()
	slot0._slide:RemoveDragEndListener()
end

slot0.DragAbsPositionX = 30

function slot0._btnshowskillOnClick(slot0)
end

function slot0._btnequiplvOnClick(slot0)
	EquipTeamListModel.instance:sortByLevel()
	slot0:_refreshEquipBtnIcon()
end

function slot0._btnequiprareOnClick(slot0)
	EquipTeamListModel.instance:sortByQuality()
	slot0:_refreshEquipBtnIcon()
end

function slot0._refreshEquipBtnIcon(slot0)
	gohelper.setActive(slot0._equipLvBtns[1], EquipTeamListModel.instance:getBtnTag() ~= 1)
	gohelper.setActive(slot0._equipLvBtns[2], slot1 == 1)
	gohelper.setActive(slot0._equipQualityBtns[1], slot1 ~= 2)
	gohelper.setActive(slot0._equipQualityBtns[2], slot1 == 2)

	slot2, slot3, slot4 = EquipTeamListModel.instance:getRankState()

	transformhelper.setLocalScale(slot0._equipLvArrow[1], 1, slot2, 1)
	transformhelper.setLocalScale(slot0._equipLvArrow[2], 1, slot2, 1)
	transformhelper.setLocalScale(slot0._equipQualityArrow[1], 1, slot3, 1)
	transformhelper.setLocalScale(slot0._equipQualityArrow[2], 1, slot3, 1)
end

function slot0._onHyperLinkClick(slot0)
	EquipController.instance:openEquipSkillTipView({
		slot0._equipMO,
		nil,
		true,
		recthelper.uiPosToScreenPos(slot0._goskillpos.transform, ViewMgr.instance:getUICanvas())
	})
end

function slot0._onDragBegin(slot0, slot1, slot2)
	slot0.startDragPosX = slot2.position.x
end

function slot0._onDragEnd(slot0, slot1, slot2)
	if uv0.DragAbsPositionX < math.abs(slot2.position.x - slot0.startDragPosX) then
		if slot3 < slot0.startDragPosX then
			slot0:_onSlideNext()
		else
			slot0:_onSlideLast()
		end
	end

	if Mathf.Clamp(slot0._currentSlideIndex - 1, 0, 3) == 3 then
		slot4 = 0
	end

	slot0._simagebgmask:LoadImage(ResUrl.getEquipBg("bg_heromask_" .. slot4 .. ".png"))
	slot0._simageblurmask:LoadImage(ResUrl.getUIMaskTexture("bg_zhezhao_" .. slot4))

	slot0.viewParam.heroMO = HeroModel.instance:getById(HeroGroupModel.instance:getCurGroupMO().heroList[slot0._currentSlideIndex])

	EquipTeamListModel.instance:openTeamEquip(slot0._currentSlideIndex - 1, slot0.viewParam.heroMO)
	slot0:_changeEquip()
	slot0:_setRoleTag()
end

function slot0._setRoleTag(slot0)
	slot2 = HeroSingleGroupModel.instance:getById(EquipTeamListModel.instance:getCurPosIndex() + 1)

	gohelper.setActive(slot0._gostorytag, slot2.aid and slot2.aid ~= -1)

	if HeroGroupModel.instance.battleId and lua_battle.configDict[slot3] then
		gohelper.setActive(slot0._goaidtag, not not HeroGroupModel.instance:isPositionOpen(slot2.id) and not (slot2.aid and slot2.aid == -1) and not (HeroGroupModel.instance:getBattleRoleNum() and slot7 < slot2.id) and slot4.playerMax < slot2.id)
	else
		gohelper.setActive(slot0._goaidtag, not slot5 and not slot6 and not slot8 and slot2.id == ModuleEnum.MaxHeroCountInGroup)
	end

	if not slot0._goaidtag.activeSelf and not slot0._gostorytag.activeSelf then
		slot0._isShowHeroTag = false

		return
	end

	gohelper.setActive(slot0._goroletags, true)

	slot0._isShowHeroTag = true
	slot9, slot10 = recthelper.getAnchor(gohelper.findChild(slot0._goposlist, "pos" .. slot1).transform)

	recthelper.setAnchor(slot0._goroletags.transform, slot9, slot10)
end

function slot0._onSlideNext(slot0)
	slot0._currentSlideIndex = slot0._currentSlideIndex + 1

	if slot0._currentSlideIndex <= slot0._maxSlideIndex then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickEquipItem, slot0._herogroupContainOffset_x[slot0._currentSlideIndex])
	else
		slot0._currentSlideIndex = slot0._maxSlideIndex
	end
end

function slot0._onSlideLast(slot0)
	slot0._currentSlideIndex = slot0._currentSlideIndex - 1

	if slot0._currentSlideIndex > 0 then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickEquipItem, slot0._herogroupContainOffset_x[slot0._currentSlideIndex])
	else
		slot0._currentSlideIndex = 1
	end
end

function slot0._editableInitView(slot0)
	slot0._strengthenattrs = slot0:getUserDataTb_()
	slot4 = ResUrl.getEquipBg

	slot0._simagenoequiptip:LoadImage(slot4("bg_xinxiang_wuzhuangtai.png"))

	slot0._equipLvBtns = slot0:getUserDataTb_()
	slot0._equipLvArrow = slot0:getUserDataTb_()
	slot0._equipQualityBtns = slot0:getUserDataTb_()
	slot0._equipQualityArrow = slot0:getUserDataTb_()

	for slot4 = 1, 2 do
		slot0._equipLvBtns[slot4] = gohelper.findChild(slot0._btnequiplv.gameObject, "btn" .. tostring(slot4))
		slot0._equipLvArrow[slot4] = gohelper.findChild(slot0._equipLvBtns[slot4], "arrow").transform
		slot0._equipQualityBtns[slot4] = gohelper.findChild(slot0._btnequiprare.gameObject, "btn" .. tostring(slot4))
		slot0._equipQualityArrow[slot4] = gohelper.findChild(slot0._equipQualityBtns[slot4], "arrow").transform
	end

	gohelper.addUIClickAudio(slot0._btnequiplv.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(slot0._btnequiprare.gameObject, AudioEnum.UI.UI_Common_Click)

	slot0._slide = SLFramework.UGUI.UIDragListener.Get(slot0._goTouchArea)
	slot0._herogroupContainOffset_x = slot0:getUserDataTb_()
	slot0._maxSlideIndex = 4

	slot0._simagemask:LoadImage(ResUrl.getEquipBg("full/mask.png"))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._heroId = EquipTeamListModel.instance:getHero() and slot1.heroId

	if EquipTeamListModel.instance:getCurPosIndex() == 3 then
		slot2 = 0
	end

	slot0._simagebgmask:LoadImage(ResUrl.getEquipBg("bg_heromask_" .. slot2 .. ".png"))
	slot0._simageblurmask:LoadImage(ResUrl.getUIMaskTexture("bg_zhezhao_" .. slot2))
	slot0:showEquipList()
	slot0:_refreshEquipBtnIcon()
	slot0:_setRoleTag()
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.ChangeEquip, slot0._changeEquip, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.onUpdateEquip, slot0._onEquipChange, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.onDeleteEquip, slot0._onEquipChange, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._hideNoEquipTip, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnCompareEquip, slot0._setMaskVisible, slot0)

	slot0._currentSlideIndex = slot0.viewParam.posIndex + 1

	slot0:_initHeorGroupItemPos()
end

function slot0.onOpenFinish(slot0)
	slot0._viewAnim.enabled = true

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.setHeroGroupEquipEffect, true)
end

function slot0._onEquipChange(slot0)
	TaskDispatcher.cancelTask(slot0._changeEquip, slot0)
	TaskDispatcher.runDelay(slot0._changeEquip, slot0, 0.1)
end

function slot0._changeEquip(slot0)
	slot0:showEquipList()
end

function slot0._initHeorGroupItemPos(slot0)
	for slot5, slot6 in ipairs(HeroGroupModel.instance:getHeroGroupItemPos()) do
		table.insert(slot0._herogroupContainOffset_x, recthelper.getAnchorX(slot6) + recthelper.getAnchorX(slot6.parent))
	end
end

function slot0._showNoEquipTip(slot0, slot1)
	if slot1 == ViewName.EquipTeamShowView then
		gohelper.setActive(slot0._simagenoequiptip.gameObject, false)
	end
end

function slot0._hideNoEquipTip(slot0, slot1)
	if slot1 == ViewName.EquipTeamShowView then
		gohelper.setActive(slot0._simagenoequiptip.gameObject, slot0._isNullEquipShow)
	end
end

function slot0.showEquipList(slot0)
	EquipTeamListModel.instance:setEquipList(true)
	EquipTeamAttrListModel.instance:SetAttrList()

	slot0._isNullEquipShow = true

	if EquipTeamAttrListModel.instance:getCount() > 0 then
		for slot6, slot7 in ipairs(EquipTeamListModel.instance:getTeamEquip()) do
			slot0._equipMO = EquipModel.instance:getEquip(slot7)
			slot0._config = slot0._equipMO.config
			slot9 = ViewMgr.instance:getOpenViewNameList()

			if slot9[#slot9] == ViewName.EquipTeamShowView or not ViewMgr.instance:isOpen(ViewName.EquipTeamShowView) then
				EquipController.instance:openEquipTeamShowView({
					slot0._equipMO.uid,
					true
				})
			end

			slot0._isNullEquipShow = false

			break
		end
	end

	if slot0._isNullEquipShow and (EquipTeamListModel.instance:getEquipList() and #slot2 or 0) > 0 then
		for slot7, slot8 in ipairs(slot2) do
			slot0._equipMO = slot8
			slot0._config = slot0._equipMO.config
			slot9 = ViewMgr.instance:getOpenViewNameList()

			if slot9[#slot9] == ViewName.EquipTeamShowView or not ViewMgr.instance:isOpen(ViewName.EquipTeamShowView) then
				EquipController.instance:openEquipTeamShowView({
					slot0._equipMO.uid,
					false
				})
			end

			slot0._isNullEquipShow = false

			break
		end
	end

	gohelper.setActive(slot0._simagenoequiptip.gameObject, slot0._isNullEquipShow)
end

function slot0._setMaskVisible(slot0, slot1)
	gohelper.setActive(slot0._simagemask.gameObject, slot1)
	gohelper.setActive(slot0._simageblurmask.gameObject, not slot1)
	gohelper.setActive(slot0._goroletags, slot0._isShowHeroTag and not slot1)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._changeEquip, slot0)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.setHeroGroupEquipEffect, false)
	gohelper.setActive(slot0._goroletags, false)
	EquipTeamListModel.instance:clearEquipList()
end

function slot0.onDestroyView(slot0)
	slot0._simagebgmask:UnLoadImage()
	slot0._simageblurmask:UnLoadImage()
	slot0._simagenoequiptip:UnLoadImage()
	slot0._simagemask:UnLoadImage()
end

return slot0
