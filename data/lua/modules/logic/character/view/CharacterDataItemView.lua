module("modules.logic.character.view.CharacterDataItemView", package.seeall)

slot0 = class("CharacterDataItemView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg")
	slot0._simagecentericon = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_centericon")
	slot0._simagelefticon = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_lefticon")
	slot0._simagerighticon = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_righticon")
	slot0._simagerighticon2 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_righticon2")
	slot0._simagemask = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_mask")
	slot0._gopointercontainer = gohelper.findChild(slot0.viewGO, "content/bottom/#go_pointcontainer")
	slot0._gopointeritem = gohelper.findChild(slot0.viewGO, "content/bottom/#go_pointcontainer/#go_pointitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onLeftPageClick(slot0)
	if not slot0.needShowPageBtn then
		return
	end

	if slot0.skinIndex <= 1 then
		return
	end

	slot0.skinIndex = slot0.skinIndex - 1
	slot0.skinId = slot0.skinList[slot0.skinIndex]

	slot0.contentAnimator:Play("switch_left", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_character_data_item_page)
end

function slot0.onRightPageClick(slot0)
	if not slot0.needShowPageBtn then
		return
	end

	if slot0.skinLen <= slot0.skinIndex then
		return
	end

	slot0.skinIndex = slot0.skinIndex + 1
	slot0.skinId = slot0.skinList[slot0.skinIndex]

	slot0.contentAnimator:Play("switch_right", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_character_data_item_page)
end

function slot0.initItem(slot0)
	slot0.itemList = slot0:getUserDataTb_()
	slot1 = nil

	for slot5 = 1, 3 do
		slot1 = slot0:getUserDataTb_()
		slot1.itemGo = gohelper.findChild(slot0.viewGO, "content/itembg" .. slot5)
		slot1.animator = slot1.itemGo:GetComponent(typeof(UnityEngine.Animator))
		slot1.itemshow = gohelper.findChild(slot1.itemGo, "go_itemshow")
		slot1.itemlock = gohelper.findChild(slot1.itemGo, "go_itemlock")
		slot1.lockicon = gohelper.findChild(slot1.itemlock, "go_lockicon")
		slot1.unlocktxt = gohelper.findChildText(slot1.lockicon, "unlocktext")
		slot1.treasurego = gohelper.findChild(slot1.itemGo, "go_itemlock/go_treasure")
		slot1.goitemshow = gohelper.findChild(slot1.itemGo, "go_itemshow")
		slot1.title1 = gohelper.findChildText(slot1.itemGo, "go_itemshow/itemtxtbg/itemnamelist/itemname1")
		slot1.title2 = gohelper.findChildText(slot1.itemGo, "go_itemshow/itemtxtbg/itemnamelist/itemname2")
		slot1.titleen = gohelper.findChildText(slot1.itemGo, "go_itemshow/itemtxtbg/itemnamelist/itemnameen")
		slot1.text = gohelper.findChildText(slot1.itemGo, "go_itemshow/itemtxtbg/descScroll/Viewport/descContent/itemtext")
		slot1.icon = gohelper.findChildSingleImage(slot1.itemGo, "go_itemshow/itemicon")
		slot1.goimageestimate = gohelper.findChild(slot1.itemGo, "go_itemshow/itemtxtbg/estimate/image_estimate")
		slot1.imageestimate = gohelper.findChildImage(slot1.itemGo, "go_itemshow/itemtxtbg/estimate/image_estimate/image_estimate")
		slot1.txtestimate = gohelper.findChildText(slot1.itemGo, "go_itemshow/itemtxtbg/estimate/txt_estimate")
		slot1.treasurebtn = gohelper.findChildButtonWithAudio(slot1.itemlock, "clickarea")

		slot1.treasurebtn:AddClickListener(slot0._onTreasureBtnClick, slot0, slot5)
		table.insert(slot0.itemList, slot1)
	end
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gopointeritem, false)

	slot0.goContent = gohelper.findChild(slot0.viewGO, "content")

	slot0._simagebg:LoadImage(ResUrl.getCommonIcon("full/bg_fmand2"))
	slot0._simagecentericon:LoadImage(ResUrl.getCharacterDataIcon("bg_fm_circle.png"))
	slot0._simagelefticon:LoadImage(ResUrl.getCommonIcon("bg_leftdown"))
	slot0._simagerighticon:LoadImage(ResUrl.getCommonIcon("bg_rightdown"))
	slot0._simagerighticon2:LoadImage(ResUrl.getCommonIcon("bg_rightup"))
	slot0._simagemask:LoadImage(ResUrl.getCommonIcon("full/bg_noise2"))
	slot0:initItem()

	slot0._effectsList = slot0:getUserDataTb_()
	slot0._dataList = {}

	CharacterController.instance:registerCallback(CharacterEvent.HeroDataAddUnlockItemFail, slot0._unlockItemCallbackFail, slot0)
	CharacterController.instance:registerCallback(CharacterEvent.HeroDataAddUnlockItem, slot0._unlockItemCallback, slot0)
end

function slot0.onUpdateParam(slot0)
	slot0:_refreshUI()
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0.viewGO, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_pieces_open)

	slot0._heroId = CharacterDataModel.instance:getCurHeroId()
	slot0.heroMo = HeroModel.instance:getByHeroId(slot0._heroId)

	slot0:initSkinInfo()
	slot0:_statStart()
	slot0:_refreshUI()
end

function slot0.sortSkin(slot0, slot1)
	return slot0 < slot1
end

function slot0.initSkinInfo(slot0)
	slot0.skinList = {
		CharacterDataConfig.DefaultSkinDataKey
	}

	for slot7, slot8 in ipairs(slot0.heroMo.skinInfoList) do
		if tabletool.indexOf(CharacterDataConfig.instance:geCharacterSkinIdList(slot0._heroId), slot8.skin) and CharacterDataConfig.instance:getDataConfig()[slot0._heroId][slot8.skin] and slot9[CharacterEnum.CharacterDataItemType.Item] then
			table.insert(slot0.skinList, slot8.skin)
		end
	end

	slot0.skinId = slot0.skinList[1]

	table.sort(slot0.skinList, uv0.sortSkin)

	slot0.skinIndex = 1
	slot0.skinLen = #slot0.skinList
	slot0.needShowPageBtn = slot0.skinLen > 1

	if slot0.needShowPageBtn then
		slot0.contentAnimator = slot0.goContent:GetComponent(typeof(UnityEngine.Animator))
		slot0.contentAnimatorEvent = slot0.goContent:GetComponent(typeof(ZProj.AnimationEventWrap))

		slot0.contentAnimatorEvent:AddEventListener("refresh", slot0._refreshUI, slot0)
	end

	slot0:initPointItem()
	slot0:initPageBtnItem()
end

function slot0.initPointItem(slot0)
	if not slot0.needShowPageBtn then
		return
	end

	slot0.pointItemList = slot0.pointItemList or slot0:getUserDataTb_()
	slot1 = nil

	for slot5, slot6 in ipairs(slot0.skinList) do
		if not slot0.pointItemList[slot5] then
			slot1 = {
				go = gohelper.cloneInPlace(slot0._gopointeritem, "point_" .. slot5)
			}
			slot1.gonormalstar = gohelper.findChild(slot1.go, "#go_nomalstar")
			slot1.golightstar = gohelper.findChild(slot1.go, "#go_lightstar")
			slot1.click = gohelper.getClick(slot1.go)

			slot1.click:AddClickListener(slot0.pointOnClick, slot0, slot5)
			table.insert(slot0.pointItemList, slot1)
		end

		gohelper.setActive(slot1.go, true)
	end

	for slot5 = #slot0.skinList + 1, #slot0.pointItemList do
		gohelper.setActive(slot0.pointItemList[slot5].go, false)
	end
end

function slot0.initPageBtnItem(slot0)
	slot0.btnLeftPage = gohelper.findChildClick(slot0.viewGO, "content/#btn_leftpage")
	slot0.btnRightPage = gohelper.findChildClick(slot0.viewGO, "content/#btn_rightpage")

	if not slot0.needShowPageBtn then
		return
	end

	slot0.btnLeftPage:AddClickListener(slot0.onLeftPageClick, slot0)
	slot0.btnRightPage:AddClickListener(slot0.onRightPageClick, slot0)
end

function slot0.pointOnClick(slot0, slot1)
	slot0.skinIndex = slot1
	slot0.skinId = slot0.skinList[slot0.skinIndex]

	slot0:_refreshUI()
end

function slot0.initDrag(slot0)
	if #slot0.skinList <= 1 then
		return
	end

	slot0._itemDrag = SLFramework.UGUI.UIDragListener.Get(slot0.goContent)

	slot0._itemDrag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._itemDrag:AddDragEndListener(slot0._onDragEnd, slot0)
end

function slot0._onDragBegin(slot0, slot1, slot2)
	slot0.startDragPosX = slot2.position.x
end

function slot0._onDragEnd(slot0, slot1, slot2)
	if math.abs(slot2.position.x - slot0.startDragPosX) > 30 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_character_view_switch)

		if slot0.startDragPosX < slot3 then
			slot0.skinIndex = slot0.skinIndex - 1

			if slot0.skinIndex < 1 then
				slot0.skinIndex = #slot0.skinList
			end
		else
			slot0.skinIndex = slot0.skinIndex + 1

			if slot0.skinIndex > #slot0.skinList then
				slot0.skinIndex = 1
			end
		end

		slot0.skinId = slot0.skinList[slot0.skinIndex]

		slot0:_refreshUI()
	end
end

function slot0._refreshUI(slot0)
	slot0:refreshItem()
	slot0:refreshPointItem()
	slot0:refreshPageBtn()
end

function slot0._unlockItemCallback(slot0, slot1, slot2)
	UIBlockMgr.instance:endBlock("playRewardsAnimtion")
	UIBlockMgrExtend.setNeedCircleMv(true)

	if slot2 >= 2 and slot2 <= 4 then
		slot0.itemList[slot2 - 1].treasurebtn:RemoveClickListener()

		slot0._dataList[slot2 - 1].isGetRewards = true
	end
end

function slot0._unlockItemCallbackFail(slot0)
	UIBlockMgr.instance:endBlock("playRewardsAnimtion")
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function slot0.refreshItem(slot0)
	slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8 = nil

	for slot12 = 1, 3 do
		slot1 = slot0.itemList[slot12]

		if not slot0._dataList[slot12] then
			slot0._dataList[slot12] = {}
		end

		slot8.itemId = slot12 + 1
		slot3 = CharacterDataConfig.instance:checkLockCondition(CharacterDataConfig.instance:getCharacterDataCO(slot0._heroId, slot0.skinId, CharacterEnum.CharacterDataItemType.Item, slot12))
		slot8.islock = slot3
		slot8.isGetRewards = HeroModel.instance:checkGetRewards(slot0._heroId, slot8.itemId)

		if slot3 then
			gohelper.setActive(slot1.itemshow, false)
			gohelper.setActive(slot1.itemlock, true)
			gohelper.setActive(slot1.lockicon, true)
			gohelper.setActive(slot1.treasurego, false)

			slot6 = {}
			slot1.unlocktxt.text = GameUtil.getSubPlaceholderLuaLang(ToastConfig.instance:getToastCO(slot2.lockText).tips, (string.splitToNumber(slot2.unlockConditine, "#")[1] ~= CharacterDataConfig.unlockConditionEpisodeID or {
				DungeonConfig.instance:getEpisodeCO(slot5[2]).name
			}) and (slot5[1] ~= CharacterDataConfig.unlockConditionRankID or {
				slot5[2] - 1
			}) and {
				slot5[2]
			})
		else
			slot0:_setItemTitlePos(slot1.title1, slot1.title2, slot1.titleen, slot2.title)

			slot1.titleen.text = slot2.titleEn
			slot1.text.text = LuaUtil.replaceSpace(slot2.text)

			slot0:_refreshEstimate(slot1, slot2)
			slot1.icon:LoadImage(ResUrl.getCharacterDataPic(slot2.icon))

			if string.nilorempty(slot2.unlockRewards) then
				gohelper.setActive(slot1.itemshow, true)
				gohelper.setActive(slot1.itemlock, false)
			elseif slot4 then
				gohelper.setActive(slot1.itemshow, true)
				gohelper.setActive(slot1.itemlock, false)
			else
				slot0:addAniEffect(slot1.goitemshow, slot8.itemId, slot0._heroId)
				gohelper.setActive(slot1.itemshow, false)
				gohelper.setActive(slot1.itemlock, true)
				gohelper.setActive(slot1.lockicon, false)
				gohelper.setActive(slot1.treasurego, true)
				slot0:checkAndCloneMaterialIfNeed(slot1.treasurego, slot12)
			end
		end
	end
end

function slot0.checkAndCloneMaterialIfNeed(slot0, slot1, slot2)
	if slot0._cloneMaterialMap and slot0._cloneMaterialMap[slot2] then
		return
	end

	slot0._cloneMaterialMap = slot0._cloneMaterialMap or {}
	slot0._cloneMaterialMap[slot2] = true
	slot3 = gohelper.findChildImage(slot1, "image")
	slot3.material = UnityEngine.Object.Instantiate(slot3.material)
	slot5 = slot3.gameObject:GetComponent(typeof(ZProj.MaterialPropsCtrl))

	slot5.mas:Clear()
	slot5.mas:Add(slot3.material)
end

function slot0.refreshPointItem(slot0)
	if not slot0.pointItemList then
		return
	end

	for slot4, slot5 in ipairs(slot0.pointItemList) do
		gohelper.setActive(slot5.gonormalstar, slot4 ~= slot0.skinIndex)
		gohelper.setActive(slot5.golightstar, slot4 == slot0.skinIndex)
	end
end

function slot0.refreshPageBtn(slot0)
	if not slot0.needShowPageBtn then
		gohelper.setActive(slot0.btnLeftPage.gameObject, false)
		gohelper.setActive(slot0.btnRightPage.gameObject, false)

		return
	end

	gohelper.setActive(slot0.btnLeftPage.gameObject, slot0.skinIndex ~= 1)
	gohelper.setActive(slot0.btnRightPage.gameObject, slot0.skinIndex ~= slot0.skinLen)
end

function slot0._onTreasureBtnClick(slot0, slot1)
	if slot0._dataList[slot1].islock then
		slot5 = ""

		GameFacade.showToast(slot3.lockText, (string.splitToNumber(CharacterDataConfig.instance:getCharacterDataCO(slot0._heroId, slot0.heroMo.skin, CharacterEnum.CharacterDataItemType.Item, slot1).unlockConditine, "#")[1] ~= CharacterDataConfig.unlockConditionEpisodeID or DungeonConfig.instance:getEpisodeCO(slot4[2]).name) and (slot4[1] == CharacterDataConfig.unlockConditionRankID and slot4[2] - 1 or slot4[2]))
	elseif not slot2.isGetRewards then
		slot3 = slot0.itemList[slot1]

		gohelper.setActive(slot3.itemshow, true)
		gohelper.setActive(slot3.itemlock, false)
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("playRewardsAnimtion")
		slot0:playAniEffect(slot2.itemId)
		slot3.animator:Play(UIAnimationName.Unlock)
		TaskDispatcher.runDelay(function ()
			HeroRpc.instance:sendItemUnlockRequest(uv0._heroId, uv1.itemId)
		end, nil, 2)
	end
end

function slot0._refreshEstimate(slot0, slot1, slot2)
	if string.nilorempty(slot2.estimate) then
		gohelper.setActive(slot1.goimageestimate.gameObject, false)

		slot1.txtestimate.text = luaLang("notestimate")
	else
		gohelper.setActive(slot1.goimageestimate.gameObject, true)

		slot4 = string.split(slot3, "#")

		UISpriteSetMgr.instance:setUiCharacterSprite(slot1.imageestimate, "fh" .. tostring(slot4[1]))

		slot1.txtestimate.text = string.format("%s", tostring(slot4[2]))
	end
end

function slot0.addAniEffect(slot0, slot1, slot2, slot3)
	if slot0:checkItemIsLock(HeroModel.instance:getByHeroId(slot3).itemUnlock, slot2) and not slot0._effectsList[slot2] then
		slot0._effectsList[slot2] = slot0:getUserDataTb_()

		if slot1:GetComponentsInChildren(typeof(UnityEngine.UI.Graphic), true) then
			slot6 = slot5:GetEnumerator()

			while slot6:MoveNext() do
				if not gohelper.findChildTextMesh(slot6.Current.gameObject, "") then
					table.insert(slot0._effectsList[slot2], UIEffectManager.instance:getUIEffect(slot6.Current.gameObject, typeof(Coffee.UIEffects.UIDissolve)))
				end
			end
		end

		for slot9, slot10 in ipairs(slot0._effectsList[slot2]) do
			slot10.width = 0.2
			slot10.softness = 1
			slot10.color = "#956C4B"
			slot10.effectFactor = 0
		end
	end
end

function slot0.playAniEffect(slot0, slot1)
	if not slot0._effectsList[slot1] then
		return
	end

	for slot6, slot7 in ipairs(slot0._effectsList[slot1]) do
		slot7.effectFactor = 1
	end

	slot0._tweenIds = slot0._tweenIds or {}

	if slot0._tweenIds[slot1] then
		ZProj.TweenHelper.KillById(slot0._tweenIds[slot1])

		slot0._tweenIds[slot1] = nil
	end

	slot0._tweenIds[slot1] = ZProj.TweenHelper.DOTweenFloat(0, 2.85, 2.85, function (slot0)
		if slot0 >= 0.35 then
			if not uv0._effectsList[uv1] then
				return
			end

			for slot5, slot6 in ipairs(slot1) do
				slot6.effectFactor = 1 - (slot0 - 0.35) / 2.5
			end
		end
	end)
end

function slot0.checkItemIsLock(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot1) do
		if slot7 == slot2 then
			return false
		end
	end

	return true
end

function slot0._statStart(slot0)
	slot0._viewTime = ServerTime.now()
end

function slot0._statEnd(slot0)
	if not slot0._heroId then
		return
	end

	if slot0._viewTime then
		CharacterController.instance:statCharacterData(StatEnum.EventName.ReadHeroItem, slot0._heroId, nil, ServerTime.now() - slot0._viewTime, slot0.viewParam and type(slot0.viewParam) == "table" and slot0.viewParam.fromHandbookView)
	end

	slot0._viewTime = nil
end

function slot0._setItemTitlePos(slot0, slot1, slot2, slot3, slot4)
	slot5 = not string.nilorempty(slot4) and string.split(slot4, "\n") or {}
	slot6 = -1.18
	slot7 = 0
	slot8 = -23.2
	slot9 = 13.2
	slot10 = -35
	slot11 = -8

	if LangSettings.instance:getCurLangShortcut() == "zh" then
		if GameUtil.getTabLen(slot5) > 1 then
			slot16 = GameUtil.utf8len(GameUtil.trimInput(slot4)) - 6 <= 4 and slot15 - 6 or 4
			slot6 = ({
				-21.7,
				-21.7,
				-24.8,
				-24.8
			})[slot16]
			slot8 = ({
				-52.32,
				-81.1,
				-73.4,
				-73.4
			})[slot16]
			slot9 = 35
			slot10 = -47.03
			slot7 = ({
				62.1,
				52.221,
				60.6,
				46.9
			})[slot16]
			slot2.text = slot5[2]
		else
			slot2.text = ""
		end
	elseif GameUtil.getTabLen(slot5) > 1 then
		slot6 = 0
		slot7 = 0
		slot8 = 0
		slot9 = 10
		slot11 = -30
		slot10 = -47.03
		slot2.text = slot5[2]
	else
		slot6 = 0
		slot9 = -10
		slot2.text = ""
	end

	slot1.text = slot5[1]

	recthelper.setAnchor(slot1.transform, slot6, slot9)
	recthelper.setAnchor(slot2.transform, slot7, slot11)
	recthelper.setAnchor(slot3.transform, slot8, slot10)
end

function slot0.onClose(slot0)
	gohelper.setActive(slot0.viewGO, false)
	slot0:_statEnd()
end

function slot0.onDestroyView(slot0)
	CharacterController.instance:unregisterCallback(CharacterEvent.HeroDataAddUnlockItemFail, slot0._unlockItemCallbackFail, slot0)
	CharacterController.instance:unregisterCallback(CharacterEvent.HeroDataAddUnlockItem, slot0._unlockItemCallback, slot0)

	if slot0._itemDrag then
		slot0._itemDrag:RemoveDragBeginListener()
		slot0._itemDrag:RemoveDragEndListener()
	end

	slot0._simagebg:UnLoadImage()
	slot0._simagecentericon:UnLoadImage()
	slot0._simagelefticon:UnLoadImage()
	slot0._simagerighticon:UnLoadImage()
	slot0._simagerighticon2:UnLoadImage()
	slot0._simagemask:UnLoadImage()

	for slot4, slot5 in ipairs(slot0.itemList) do
		slot5.icon:UnLoadImage()
		slot5.treasurebtn:RemoveClickListener()
	end

	if slot0.pointItemList then
		for slot4, slot5 in ipairs(slot0.pointItemList) do
			slot5.click:RemoveClickListener()
		end
	end

	if slot0._tweenIds then
		for slot4, slot5 in pairs(slot0._tweenIds) do
			ZProj.TweenHelper.KillById(slot5)
		end

		slot0._tweenIds = nil
	end

	if slot0.needShowPageBtn then
		slot0.btnLeftPage:RemoveClickListener()
		slot0.btnRightPage:RemoveClickListener()
		slot0.contentAnimatorEvent:RemoveAllEventListener()
	end
end

return slot0
