module("modules.logic.handbook.view.HandBookCharacterView", package.seeall)

slot0 = class("HandBookCharacterView", BaseView)

function slot0.onInitView(slot0)
	slot0._goContainer = gohelper.findChild(slot0.viewGO, "#go_center/handbookcharacterview")
	slot0._simagebg = gohelper.findChildSingleImage(slot0._goContainer, "bg/#simage_bg")
	slot0._simageline = gohelper.findChildSingleImage(slot0._goContainer, "bg/#simage_line")
	slot0._gocover = gohelper.findChild(slot0._goContainer, "#go_cover")
	slot0._simagecoverbg2 = gohelper.findChildSingleImage(slot0._goContainer, "#go_cover/#simage_coverbg2")
	slot0._txttitleName = gohelper.findChildText(slot0._goContainer, "#go_cover/left/#txt_titleName")
	slot0._simagecovericon = gohelper.findChildSingleImage(slot0._goContainer, "#go_cover/left/mask/#simage_covericon")
	slot0._gocoverrightpage = gohelper.findChild(slot0._goContainer, "#go_cover/right/#go_coverrightpage")
	slot0._simagepagebg = gohelper.findChild(slot0._goContainer, "#simage_pagebg")
	slot0._gocharacteritem = gohelper.findChild(slot0._goContainer, "#go_characteritem")
	slot0._goleftpage = gohelper.findChild(slot0._goContainer, "#go_leftpage")
	slot0._goleftarrow = gohelper.findChild(slot0._goContainer, "#go_leftarrow")
	slot0._gorightpage = gohelper.findChild(slot0._goContainer, "#go_rightpage")
	slot0._gorightarrow = gohelper.findChild(slot0._goContainer, "#go_rightarrow")
	slot0._gocoverrightarrow = gohelper.findChild(slot0._goContainer, "#go_coverrightarrow")
	slot0._btnrarerank = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_center/handbookcharacterview/#go_upleft/#btn_rarerank")
	slot0._goarrow = gohelper.findChild(slot0.viewGO, "#go_center/handbookcharacterview/#go_upleft/#btn_rarerank/btn2/txt/#go_arrow")
	slot0._btnclassify = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_center/handbookcharacterview/#go_upleft/#btn_classify")
	slot0._txtpagecount = gohelper.findChildText(slot0.viewGO, "#go_center/handbookcharacterview/#txt_pagecount")
	slot0._gohumantip = gohelper.findChild(slot0._goContainer, "#go_tips")
	slot0._gohumantipAnimtor = slot0._gohumantip:GetComponent(gohelper.Type_Animator)
	slot0._gohumansubtip = gohelper.findChild(slot0._goContainer, "#go_tips/Tips")
	slot0._gotipclose = gohelper.findChild(slot0._goContainer, "#go_tipclose")
	slot0._gohumantipbutton = gohelper.findChildButtonWithAudio(slot0._goContainer, "#go_tips/Button")
	slot0._gotipcloseclick = gohelper.getClickWithDefaultAudio(slot0._gotipclose)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnrarerank:AddClickListener(slot0._btnrarerankOnClick, slot0)
	slot0._btnclassify:AddClickListener(slot0._btnclassifyOnClick, slot0)
	slot0._gohumantipbutton:AddClickListener(slot0.onClickTipBtn, slot0)
	slot0._gotipcloseclick:AddClickListener(slot0.onClickCloseTipBtn, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnrarerank:RemoveClickListener()
	slot0._btnclassify:RemoveClickListener()
	slot0._gohumantipbutton:RemoveClickListener()
	slot0._gotipcloseclick:RemoveClickListener()
end

function slot0.onClickTipBtn(slot0)
	if slot0.heroType ~= 6 then
		return
	end

	gohelper.setActive(slot0._gohumansubtip, true)
	gohelper.setActive(slot0._gotipclose, true)
end

function slot0.onClickCloseTipBtn(slot0)
	if slot0.heroType ~= 6 then
		return
	end

	gohelper.setActive(slot0._gohumansubtip, false)
	gohelper.setActive(slot0._gotipclose, false)
end

function slot0._btnrarerankOnClick(slot0)
	slot0._isSortL2H = not slot0._isSortL2H

	slot0:_refreshFilterState()
	slot0:_refreshShowFirstPage()
end

function slot0._btnclassifyOnClick(slot0)
	slot1 = {
		dmgs = {},
		attrs = {},
		locations = {}
	}

	tabletool.addValues(slot1.dmgs, slot0._selectDmgs)
	tabletool.addValues(slot1.attrs, slot0._selectCareers)
	tabletool.addValues(slot1.locations, slot0._selectLocations)
	CharacterController.instance:openCharacterFilterView(slot1)
end

function slot0._onFilterList(slot0, slot1)
	if slot0:_isAllHeroType() then
		for slot5 = 1, #slot1.dmgs do
			slot0._selectDmgs[slot5] = slot1.dmgs[slot5]
		end

		for slot5 = 1, #slot1.attrs do
			slot0._selectCareers[slot5] = slot1.attrs[slot5]
		end

		for slot5 = 1, #slot1.locations do
			slot0._selectLocations[slot5] = slot1.locations[slot5]
		end

		slot0._dmgFilterCount = slot0:_findFilterCount(slot0._selectDmgs)
		slot0._careerFilterCount = slot0:_findFilterCount(slot0._selectCareers)
		slot0._locationFilterCount = slot0:_findFilterCount(slot0._selectLocations)

		slot0:_refreshFilterState()
		slot0:_refreshShowFirstPage()
	end
end

function slot0._findFilterCount(slot0, slot1)
	for slot6, slot7 in pairs(slot1) do
		if slot7 then
			slot2 = 0 + 1
		end
	end

	return slot2
end

slot0.DragAbsPositionX = 50
slot0.AnimatorBlockName = "animatorBlockName"

function slot0._editableInitView(slot0)
	slot0._simagecoverbg1peper1 = gohelper.findChildSingleImage(slot0._goContainer, "#go_cover/#simage_coverbg1/peper1")
	slot0._simagecoverbg1peper2 = gohelper.findChildSingleImage(slot0._goContainer, "#go_cover/#simage_coverbg1/peper2")
	slot0._coverAnim = slot0._gocover:GetComponent(typeof(UnityEngine.Animator))
	slot0._containerAnim = ZProj.ProjAnimatorPlayer.Get(slot0._goContainer)

	gohelper.setActive(slot0._gocharacteritem, false)

	slot0._goarrowTrs = slot0._goarrow.transform
	slot0.items = {}
	slot0.coveritems = {}
	slot0.characterClickTabs = slot0:getUserDataTb_()
	slot1 = slot0._btnclassify.gameObject
	slot0._goFiltering = gohelper.findChild(slot1, "btn2")
	slot5 = "btn1"
	slot0._goFilterno = gohelper.findChild(slot1, slot5)

	for slot5 = 1, 7 do
		slot0["_gocharacter" .. slot5] = slot5 >= 4 and gohelper.findChild(slot0._gorightpage, "#go_character" .. slot5) or gohelper.findChild(slot0._goleftpage, "#go_character" .. slot5)
		slot6 = gohelper.getClick(slot0["_gocharacter" .. slot5])

		slot6:AddClickListener(slot0.characterOnClick, slot0, slot5)
		table.insert(slot0.characterClickTabs, slot6)
		table.insert(slot0.items, slot0:findItemSubNodes(slot0["_gocharacter" .. slot5]))
	end

	for slot5 = 4, 7 do
		slot0["_gocorvercharacter" .. slot5] = gohelper.findChild(slot0._gocoverrightpage, "#go_corvercharacter" .. slot5)
		slot6 = gohelper.getClick(slot0["_gocorvercharacter" .. slot5])

		slot6:AddClickListener(slot0.characterOnClick, slot0, slot5)
		table.insert(slot0.characterClickTabs, slot6)
		table.insert(slot0.coveritems, slot0:findItemSubNodes(slot0["_gocorvercharacter" .. slot5]))
	end

	slot0._leftArrowClick = gohelper.findChildClickWithAudio(slot0._goleftarrow, "clickArea", AudioEnum.UI.play_ui_screenplay_photo_click)
	slot0._rightArrowClick = gohelper.findChildClickWithAudio(slot0._gorightarrow, "clickArea", AudioEnum.UI.play_ui_screenplay_photo_click)
	slot0._coverRightArrowClick = gohelper.findChildClickWithAudio(slot0._gocoverrightarrow, "clickArea", AudioEnum.UI.play_ui_screenplay_photo_click)

	slot0._leftArrowClick:AddClickListener(slot0.leftPageOnClick, slot0)
	slot0._rightArrowClick:AddClickListener(slot0.rightPageOnClick, slot0)
	slot0._coverRightArrowClick:AddClickListener(slot0.rightPageOnClick, slot0)

	slot0.currentPage = 1
	slot0.maxPage = 1
	slot0.startDragPosX = 0
	slot0._firstPageNum = 4
	slot0._isSortL2H = false
	slot0._dmgFilterCount = 0
	slot0._careerFilterCount = 0
	slot0._locationFilterCount = 0
	slot0._selectDmgs = {
		false,
		false
	}
	slot0._selectCareers = {
		false,
		false,
		false,
		false,
		false,
		false
	}
	slot0._selectLocations = {
		false,
		false,
		false,
		false,
		false,
		false
	}

	slot0._simagebg:LoadImage(ResUrl.getHandbookCharacterIcon("full/bg111"))
	slot0._simageline:LoadImage(ResUrl.getHandbookCharacterIcon("bg_xian"))
	slot0._simagecoverbg2:LoadImage(ResUrl.getHandbookCharacterIcon("zhi2"))
	slot0._simagecoverbg1peper1:LoadImage(ResUrl.getHandbookCharacterIcon("peper_01"))
	slot0._simagecoverbg1peper2:LoadImage(ResUrl.getHandbookCharacterIcon("peper_02"))
end

function slot0.characterOnClick(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Player_Interface_Open)

	if not slot0.configHeroList[(slot0.currentPage - 2) * 7 + slot0:getFirstPageHeroNum() + slot1] then
		return
	end

	if slot0:_isAllHeroType() then
		if not HeroModel.instance:getByHeroId(slot3.id) then
			-- Nothing
		end

		ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
			heroId = slot4,
			skinId = slot3.skinId,
			skinColorStr = "#1A1A1A"
		})
	elseif slot5 then
		slot0:openCharacterView(slot4)
	else
		GameFacade.showToast(ToastEnum.HandBook1)
	end

	if slot5 and not HandbookModel.instance:isRead(HandbookEnum.Type.Character, slot4) then
		HandbookRpc.instance:sendHandbookReadRequest(HandbookEnum.Type.Character, slot4)

		if slot0.currentPage == 1 and not slot0:_isAllHeroType() then
			gohelper.setActive(slot0.coveritems[slot1 - 3].gonew, false)
		else
			gohelper.setActive(slot0.items[slot1].gonew, false)
		end
	end
end

function slot0.openCharacterView(slot0, slot1)
	CharacterController.instance:openCharacterDataView({
		fromHandbookView = true,
		heroId = slot1
	})
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(HandbookController.instance, HandbookController.EventName.OnShowSubCharacterView, slot0.reallyOpenView, slot0)
	slot0:addEventCb(HandbookController.instance, HandbookController.EventName.PlayCharacterSwitchCloseAnim, slot0._playCloseViewAnim, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, slot0._onCloseFullView, slot0, LuaEventSystem.Low)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.FilterBackpack, slot0._onFilterList, slot0)
end

function slot0.findItemSubNodes(slot0, slot1)
	slot2 = gohelper.clone(slot0._gocharacteritem, slot1)

	gohelper.setActive(slot2, true)

	slot3 = {
		gohero = gohelper.findChild(slot2, "hero"),
		gonohero = gohelper.findChild(slot2, "nohero"),
		goempty = gohelper.findChild(slot2, "#go_empty"),
		gocircle = gohelper.findChild(slot2, "circle"),
		simagehero = gohelper.findChildSingleImage(slot2, "hero/simage_hero"),
		simagesignature = gohelper.findChildSingleImage(slot2, "hero/txt_name/image_career/simage_signature"),
		careerIcon = gohelper.findChildImage(slot2, "hero/txt_name/image_career"),
		gonew = gohelper.findChild(slot2, "hero/go_new"),
		txtname = gohelper.findChildTextMesh(slot2, slot7),
		gostars = {}
	}
	slot7 = "hero/txt_name"

	for slot7 = 1, 6 do
		table.insert(slot3.gostars, gohelper.findChild(slot2, "hero/txt_name/star/star" .. slot7))
	end

	slot3.simagenohero = gohelper.findChildSingleImage(slot2, "nohero/simage_nohero")
	slot3.txtnoheroname = gohelper.findChildTextMesh(slot2, "nohero/txt_noheroname")

	gohelper.setActive(slot3.gonew, false)

	return slot3
end

function slot0._onCloseFullView(slot0)
	if slot0.currentPage == 1 then
		slot0._coverAnim:Play(UIAnimationName.Open, 0, 0)
	end

	slot0._containerAnim:Play(UIAnimationName.Open)
end

function slot0.leftPageOnClick(slot0)
	if slot0.currentPage > 1 then
		UIBlockMgr.instance:startBlock(uv0.AnimatorBlockName)
		slot0._containerAnim:Play("right_out", function (slot0)
			slot0:refreshCharacterBook(slot0.currentPage - 1)
			slot0._containerAnim:Play("right_in")
			UIBlockMgr.instance:endBlock(uv0.AnimatorBlockName)
		end, slot0)
	end
end

function slot0.rightPageOnClick(slot0)
	if slot0.currentPage < slot0.maxPage then
		UIBlockMgr.instance:startBlock(uv0.AnimatorBlockName)
		slot0._containerAnim:Play("left_out", function (slot0)
			slot0:refreshCharacterBook(slot0.currentPage + 1)
			slot0._containerAnim:Play("left_in")
			UIBlockMgr.instance:endBlock(uv0.AnimatorBlockName)
		end, slot0)
	end
end

function slot0.reallyOpenView(slot0, slot1)
	slot0.heroType = slot1

	slot0:refreshHumanTip()
	slot0:_resetFilterParam()

	slot0.configHeroList = slot0:_getConfigHeroList()
	slot0.maxPage = slot0:calculateMaxPageNum()

	slot0:refreshCharacterBook(1)
	slot0:refreshCoverInfo()

	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._goContainer)

	slot0._drag:AddDragBeginListener(slot0.onDragBeginHandle, slot0)
	slot0._drag:AddDragEndListener(slot0.onDragEndHandle, slot0)
	slot0._coverAnim:Play(UIAnimationName.Open, 0, 0)
	slot0._gohumantipAnimtor:Play(UIAnimationName.Open, 0, 0)
	slot0:_refreshFilterState()
end

function slot0.refreshHumanTip(slot0)
	gohelper.setActive(slot0._gohumantip, slot0.heroType == 6)
	gohelper.setActive(slot0._gohumansubtip, false)
	gohelper.setActive(slot0._gotipclose, false)
end

function slot0._resetFilterParam(slot0)
	slot0:_resetFilterList(slot0._selectDmgs)
	slot0:_resetFilterList(slot0._selectCareers)
	slot0:_resetFilterList(slot0._selectLocations)

	slot0._dmgFilterCount = 0
	slot0._careerFilterCount = 0
	slot0._locationFilterCount = 0
	slot0._isSortL2H = false
end

function slot0._resetFilterList(slot0, slot1)
	for slot5 = 1, #slot1 do
		slot1[slot5] = false
	end
end

function slot0._refreshShowFirstPage(slot0)
	slot0.configHeroList = slot0:_getConfigHeroList()
	slot0.maxPage = slot0:calculateMaxPageNum()

	slot0:refreshCharacterBook(1)
	slot0:refreshCoverInfo()
end

function slot0._refreshFilterState(slot0)
	if slot0:_isAllHeroType() then
		slot1 = slot0._dmgFilterCount > 0 or slot0._careerFilterCount > 0 or slot0._locationFilterCount > 0

		gohelper.setActive(slot0._goFiltering, slot1)
		gohelper.setActive(slot0._goFilterno, not slot1)
		transformhelper.setLocalScale(slot0._goarrowTrs, 1, slot0._isSortL2H and -1 or 1, 1)
	end
end

function slot0._getConfigHeroList(slot0)
	slot2 = uv0._sortFuncH2L

	for slot7, slot8 in ipairs(HeroConfig.instance:getHeroesList()) do
		if slot0:_checkConfig(slot8) then
			table.insert({}, slot8)
		end
	end

	if slot0:_isAllHeroType() and slot0._isSortL2H then
		slot2 = uv0._sortFuncL2H
	end

	table.sort(slot1, slot2)

	return slot1
end

function slot0._checkConfig(slot0, slot1)
	if not slot0:_isAllHeroType() then
		return slot1.heroType == slot0.heroType
	end

	slot2 = {
		101,
		102,
		103,
		104,
		106,
		107
	}

	if (slot0._dmgFilterCount == 0 or slot0._selectDmgs[slot1.dmgType]) and (slot0._careerFilterCount == 0 or slot0._selectCareers[slot1.career]) then
		if slot0._locationFilterCount == 0 then
			return true
		end

		slot3 = string.splitToNumber(slot1.battleTag, "#")

		for slot7, slot8 in ipairs(slot2) do
			for slot12, slot13 in pairs(slot3) do
				if slot0._selectLocations[slot7] and slot13 == slot8 then
					return true
				end
			end
		end
	end

	return false
end

function slot0._sortFuncH2L(slot0, slot1)
	if slot0.rare ~= slot1.rare then
		return slot1.rare < slot0.rare
	else
		return slot0.id < slot1.id
	end
end

function slot0._sortFuncL2H(slot0, slot1)
	if slot0.rare ~= slot1.rare then
		return slot0.rare < slot1.rare
	else
		return slot0.id < slot1.id
	end
end

function slot0.refreshCoverInfo(slot0)
	slot1 = not slot0:_isAllHeroType()

	gohelper.setActive(slot0._txttitleName, slot1)
	gohelper.setActive(slot0._simagecovericon, slot1)

	if slot1 then
		slot2 = lua_handbook_character.configDict[slot0.heroType]
		slot0._txttitleName.text = slot2.name

		slot0._simagecovericon:LoadImage(ResUrl.getHandbookCharacterIcon("coer" .. slot2.icon))
	end
end

function slot0.refreshCharacterBook(slot0, slot1)
	if slot0.maxPage < slot1 then
		slot1 = slot0.maxPage
	end

	if slot1 < 1 then
		slot1 = 1
	end

	slot0.currentPage = slot1

	if slot1 == 1 then
		gohelper.setActive(slot0._gocover, true)
		gohelper.setActive(slot0._simagepagebg.gameObject, false)
		gohelper.setActive(slot0._goleftpage, slot0:getFirstPageLeftHeroNum() > 0)
		gohelper.setActive(slot0._gorightpage, false)

		for slot6 = 1, 4 do
			slot0:showBookItem(slot0.coveritems[slot6], slot0.configHeroList[slot6 + slot2], slot6 + 3, true)
		end

		for slot6 = 1, slot2 do
			slot0:showBookItem(slot0.items[slot6], slot0.configHeroList[slot6], slot6, false)
		end
	else
		gohelper.setActive(slot0._gocover, false)
		gohelper.setActive(slot0._simagepagebg.gameObject, true)
		gohelper.setActive(slot0._goleftpage, true)
		gohelper.setActive(slot0._gorightpage, true)

		for slot6 = 1, 7 do
			slot0:showBookItem(slot0.items[slot6], slot0.configHeroList[(slot1 - 2) * 7 + slot0:getFirstPageHeroNum() + slot6], slot6, false)
		end
	end

	gohelper.setActive(slot0._goleftarrow, slot0.currentPage > 1)
	gohelper.setActive(slot0._gorightarrow, slot0.currentPage < slot0.maxPage)
	gohelper.setActive(slot0._gocoverrightarrow, slot0.currentPage < slot0.maxPage)
	gohelper.setActive(slot0._txtpagecount, slot0:_isAllHeroType())

	if slot0:_isAllHeroType() then
		slot0._txtpagecount.text = slot0.currentPage .. "/" .. slot0.maxPage
	end
end

slot1 = {
	jp = {
		transformWidth = 170,
		transformAnchorX = 55,
		enableAutoSizing = true,
		fontSizeMax = 26,
		fontSizeMin = 20,
		characterSpacing = -9
	},
	en = {
		transformWidth = 170,
		transformAnchorX = 55,
		enableAutoSizing = true,
		fontSizeMax = 26,
		fontSizeMin = 20,
		characterSpacing = 0
	}
}

function slot0.showBookItem(slot0, slot1, slot2, slot3, slot4)
	if slot4 then
		gohelper.setActive(slot0["_gocorvercharacter" .. slot3], slot0:_isAllHeroType() or slot2)
	else
		gohelper.setActive(slot0["_gocharacter" .. slot3], slot5 or slot2)
	end

	if slot2 then
		slot7 = HeroModel.instance:getByHeroId(slot2.id) and true or false

		gohelper.setActive(slot1.gohero, slot7 or slot5)
		gohelper.setActive(slot1.gonohero, not slot7)
		gohelper.setActive(slot1.simagehero, slot7)

		if slot7 then
			slot1.simagehero:LoadImage(ResUrl.getHandbookheroIcon(slot2.skinId))
		else
			slot1.simagenohero:LoadImage(ResUrl.getHandbookheroIcon(slot2.skinId))
			gohelper.setActive(slot1.txtnoheroname, not slot8)
		end

		if slot8 then
			slot1.simagesignature:LoadImage(ResUrl.getSignature(slot2.signature))

			slot13 = "lssx_" .. tostring(slot2.career)

			UISpriteSetMgr.instance:setCommonSprite(slot1.careerIcon, slot13)

			slot9 = LangSettings.instance:getCurLangShortcut()

			for slot13 = 1, 6 do
				gohelper.setActive(slot1.gostars[slot13], slot13 <= slot2.rare + 1)
			end

			if (slot3 == 5 or slot3 == 7) and uv0[slot9] then
				recthelper.setWidth(slot1.txtname.transform, slot10.transformWidth)
				recthelper.setAnchorX(slot1.txtname.transform, slot10.transformAnchorX)

				if slot1.txtname:GetComponent(typeof(TMPro.TextMeshProUGUI)) then
					slot11.enableAutoSizing = slot10.enableAutoSizing
					slot11.fontSizeMin = slot10.fontSizeMin
					slot11.fontSizeMax = slot10.fontSizeMax
					slot1.txtname.characterSpacing = slot10.characterSpacing
				end
			end

			slot1.txtname.text = slot2.name
		end
	else
		gohelper.setActive(slot1.gohero, false)
		gohelper.setActive(slot1.gonohero, false)
	end

	gohelper.setActive(slot1.gocircle, slot2)
	gohelper.setActive(slot1.goempty, slot5 and not slot2)
end

function slot0.calculateMaxPageNum(slot0)
	return math.ceil((#slot0.configHeroList - slot0:getFirstPageHeroNum()) / 7) + 1
end

function slot0.getFirstPageLeftHeroNum(slot0)
	return math.max(0, slot0:getFirstPageHeroNum() - 4)
end

function slot0.getFirstPageHeroNum(slot0)
	if slot0:_isAllHeroType() then
		return 7
	end

	return 4
end

function slot0._isAllHeroType(slot0)
	return slot0.heroType == HandbookEnum.HeroType.AllHero
end

function slot0.onDragBeginHandle(slot0, slot1, slot2)
	slot0.startDragPosX = slot2.position.x
end

function slot0.onDragEndHandle(slot0, slot1, slot2)
	if uv0.DragAbsPositionX < math.abs(slot2.position.x - slot0.startDragPosX) then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_screenplay_photo_click)

		if slot3 < slot0.startDragPosX then
			slot0:rightPageOnClick()
		else
			slot0:leftPageOnClick()
		end
	end
end

function slot0._playCloseViewAnim(slot0)
	if slot0.currentPage == 1 then
		slot0._coverAnim:Play(UIAnimationName.Close, 0, 0)
	end

	slot0._containerAnim:Play(UIAnimationName.Close)
	slot0._gohumantipAnimtor:Play(UIAnimationName.Close)
	gohelper.setActive(slot0._gohumansubtip, false)
	gohelper.setActive(slot0._gotipclose, false)
end

function slot0.onClose(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simageline:UnLoadImage()
	slot0._simagecoverbg2:UnLoadImage()
	slot0._simagecoverbg1peper1:UnLoadImage()
	slot0._simagecoverbg1peper1:UnLoadImage()
end

function slot0.onDestroyView(slot0)
	slot0._leftArrowClick:RemoveClickListener()
	slot0._rightArrowClick:RemoveClickListener()
	slot0._coverRightArrowClick:RemoveClickListener()

	for slot4, slot5 in ipairs(slot0.characterClickTabs) do
		slot5:RemoveClickListener()
	end

	if slot0._drag then
		slot0._drag:RemoveDragBeginListener()
		slot0._drag:RemoveDragEndListener()
	end

	slot0:removeEventCb(HandbookController.instance, HandbookController.EventName.OnShowSubCharacterView, slot0.reallyOpenView, slot0)
	slot0:removeEventCb(HandbookController.instance, HandbookController.EventName.PlayCharacterSwitchCloseAnim, slot0._playCloseViewAnim, slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.FilterBackpack, slot0._onFilterList, slot0)
	slot0._simagecovericon:UnLoadImage()
end

return slot0
