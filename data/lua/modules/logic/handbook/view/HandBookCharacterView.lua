module("modules.logic.handbook.view.HandBookCharacterView", package.seeall)

local var_0_0 = class("HandBookCharacterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goContainer = gohelper.findChild(arg_1_0.viewGO, "#go_center/handbookcharacterview")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0._goContainer, "bg/#simage_bg")
	arg_1_0._simageline = gohelper.findChildSingleImage(arg_1_0._goContainer, "bg/#simage_line")
	arg_1_0._gocover = gohelper.findChild(arg_1_0._goContainer, "#go_cover")
	arg_1_0._simagecoverbg2 = gohelper.findChildSingleImage(arg_1_0._goContainer, "#go_cover/#simage_coverbg2")
	arg_1_0._txttitleName = gohelper.findChildText(arg_1_0._goContainer, "#go_cover/left/#txt_titleName")
	arg_1_0._simagecovericon = gohelper.findChildSingleImage(arg_1_0._goContainer, "#go_cover/left/mask/#simage_covericon")
	arg_1_0._gocoverrightpage = gohelper.findChild(arg_1_0._goContainer, "#go_cover/right/#go_coverrightpage")
	arg_1_0._simagepagebg = gohelper.findChild(arg_1_0._goContainer, "#simage_pagebg")
	arg_1_0._gocharacteritem = gohelper.findChild(arg_1_0._goContainer, "#go_characteritem")
	arg_1_0._goleftpage = gohelper.findChild(arg_1_0._goContainer, "#go_leftpage")
	arg_1_0._goleftarrow = gohelper.findChild(arg_1_0._goContainer, "#go_leftarrow")
	arg_1_0._gorightpage = gohelper.findChild(arg_1_0._goContainer, "#go_rightpage")
	arg_1_0._gorightarrow = gohelper.findChild(arg_1_0._goContainer, "#go_rightarrow")
	arg_1_0._gocoverrightarrow = gohelper.findChild(arg_1_0._goContainer, "#go_coverrightarrow")
	arg_1_0._btnrarerank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_center/handbookcharacterview/#go_upleft/#btn_rarerank")
	arg_1_0._goarrow = gohelper.findChild(arg_1_0.viewGO, "#go_center/handbookcharacterview/#go_upleft/#btn_rarerank/btn2/txt/#go_arrow")
	arg_1_0._btnclassify = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_center/handbookcharacterview/#go_upleft/#btn_classify")
	arg_1_0._txtpagecount = gohelper.findChildText(arg_1_0.viewGO, "#go_center/handbookcharacterview/#txt_pagecount")
	arg_1_0._gohumantip = gohelper.findChild(arg_1_0._goContainer, "#go_tips")
	arg_1_0._gohumantipAnimtor = arg_1_0._gohumantip:GetComponent(gohelper.Type_Animator)
	arg_1_0._gohumansubtip = gohelper.findChild(arg_1_0._goContainer, "#go_tips/Tips")
	arg_1_0._gotipclose = gohelper.findChild(arg_1_0._goContainer, "#go_tipclose")
	arg_1_0._gohumantipbutton = gohelper.findChildButtonWithAudio(arg_1_0._goContainer, "#go_tips/Button")
	arg_1_0._gotipcloseclick = gohelper.getClickWithDefaultAudio(arg_1_0._gotipclose)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnrarerank:AddClickListener(arg_2_0._btnrarerankOnClick, arg_2_0)
	arg_2_0._btnclassify:AddClickListener(arg_2_0._btnclassifyOnClick, arg_2_0)
	arg_2_0._gohumantipbutton:AddClickListener(arg_2_0.onClickTipBtn, arg_2_0)
	arg_2_0._gotipcloseclick:AddClickListener(arg_2_0.onClickCloseTipBtn, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnrarerank:RemoveClickListener()
	arg_3_0._btnclassify:RemoveClickListener()
	arg_3_0._gohumantipbutton:RemoveClickListener()
	arg_3_0._gotipcloseclick:RemoveClickListener()
end

function var_0_0.onClickTipBtn(arg_4_0)
	if arg_4_0.heroType ~= 6 then
		return
	end

	gohelper.setActive(arg_4_0._gohumansubtip, true)
	gohelper.setActive(arg_4_0._gotipclose, true)
end

function var_0_0.onClickCloseTipBtn(arg_5_0)
	if arg_5_0.heroType ~= 6 then
		return
	end

	gohelper.setActive(arg_5_0._gohumansubtip, false)
	gohelper.setActive(arg_5_0._gotipclose, false)
end

function var_0_0._btnrarerankOnClick(arg_6_0)
	arg_6_0._isSortL2H = not arg_6_0._isSortL2H

	arg_6_0:_refreshFilterState()
	arg_6_0:_refreshShowFirstPage()
end

function var_0_0._btnclassifyOnClick(arg_7_0)
	local var_7_0 = {
		dmgs = {},
		attrs = {},
		locations = {}
	}

	tabletool.addValues(var_7_0.dmgs, arg_7_0._selectDmgs)
	tabletool.addValues(var_7_0.attrs, arg_7_0._selectCareers)
	tabletool.addValues(var_7_0.locations, arg_7_0._selectLocations)
	CharacterController.instance:openCharacterFilterView(var_7_0)
end

function var_0_0._onFilterList(arg_8_0, arg_8_1)
	if arg_8_0:_isAllHeroType() then
		for iter_8_0 = 1, #arg_8_1.dmgs do
			arg_8_0._selectDmgs[iter_8_0] = arg_8_1.dmgs[iter_8_0]
		end

		for iter_8_1 = 1, #arg_8_1.attrs do
			arg_8_0._selectCareers[iter_8_1] = arg_8_1.attrs[iter_8_1]
		end

		for iter_8_2 = 1, #arg_8_1.locations do
			arg_8_0._selectLocations[iter_8_2] = arg_8_1.locations[iter_8_2]
		end

		arg_8_0._dmgFilterCount = arg_8_0:_findFilterCount(arg_8_0._selectDmgs)
		arg_8_0._careerFilterCount = arg_8_0:_findFilterCount(arg_8_0._selectCareers)
		arg_8_0._locationFilterCount = arg_8_0:_findFilterCount(arg_8_0._selectLocations)

		arg_8_0:_refreshFilterState()
		arg_8_0:_refreshShowFirstPage()
	end
end

function var_0_0._findFilterCount(arg_9_0, arg_9_1)
	local var_9_0 = 0

	for iter_9_0, iter_9_1 in pairs(arg_9_1) do
		if iter_9_1 then
			var_9_0 = var_9_0 + 1
		end
	end

	return var_9_0
end

var_0_0.DragAbsPositionX = 50
var_0_0.AnimatorBlockName = "animatorBlockName"

function var_0_0._editableInitView(arg_10_0)
	arg_10_0._simagecoverbg1peper1 = gohelper.findChildSingleImage(arg_10_0._goContainer, "#go_cover/#simage_coverbg1/peper1")
	arg_10_0._simagecoverbg1peper2 = gohelper.findChildSingleImage(arg_10_0._goContainer, "#go_cover/#simage_coverbg1/peper2")
	arg_10_0._coverAnim = arg_10_0._gocover:GetComponent(typeof(UnityEngine.Animator))
	arg_10_0._containerAnim = ZProj.ProjAnimatorPlayer.Get(arg_10_0._goContainer)

	gohelper.setActive(arg_10_0._gocharacteritem, false)

	arg_10_0._goarrowTrs = arg_10_0._goarrow.transform
	arg_10_0.items = {}
	arg_10_0.coveritems = {}
	arg_10_0.characterClickTabs = arg_10_0:getUserDataTb_()

	local var_10_0 = arg_10_0._btnclassify.gameObject

	arg_10_0._goFiltering = gohelper.findChild(var_10_0, "btn2")
	arg_10_0._goFilterno = gohelper.findChild(var_10_0, "btn1")

	for iter_10_0 = 1, 7 do
		arg_10_0["_gocharacter" .. iter_10_0] = iter_10_0 >= 4 and gohelper.findChild(arg_10_0._gorightpage, "#go_character" .. iter_10_0) or gohelper.findChild(arg_10_0._goleftpage, "#go_character" .. iter_10_0)

		local var_10_1 = gohelper.getClick(arg_10_0["_gocharacter" .. iter_10_0])

		var_10_1:AddClickListener(arg_10_0.characterOnClick, arg_10_0, iter_10_0)
		table.insert(arg_10_0.characterClickTabs, var_10_1)
		table.insert(arg_10_0.items, arg_10_0:findItemSubNodes(arg_10_0["_gocharacter" .. iter_10_0]))
	end

	for iter_10_1 = 4, 7 do
		arg_10_0["_gocorvercharacter" .. iter_10_1] = gohelper.findChild(arg_10_0._gocoverrightpage, "#go_corvercharacter" .. iter_10_1)

		local var_10_2 = gohelper.getClick(arg_10_0["_gocorvercharacter" .. iter_10_1])

		var_10_2:AddClickListener(arg_10_0.characterOnClick, arg_10_0, iter_10_1)
		table.insert(arg_10_0.characterClickTabs, var_10_2)
		table.insert(arg_10_0.coveritems, arg_10_0:findItemSubNodes(arg_10_0["_gocorvercharacter" .. iter_10_1]))
	end

	arg_10_0._leftArrowClick = gohelper.findChildClickWithAudio(arg_10_0._goleftarrow, "clickArea", AudioEnum.UI.play_ui_screenplay_photo_click)
	arg_10_0._rightArrowClick = gohelper.findChildClickWithAudio(arg_10_0._gorightarrow, "clickArea", AudioEnum.UI.play_ui_screenplay_photo_click)
	arg_10_0._coverRightArrowClick = gohelper.findChildClickWithAudio(arg_10_0._gocoverrightarrow, "clickArea", AudioEnum.UI.play_ui_screenplay_photo_click)

	arg_10_0._leftArrowClick:AddClickListener(arg_10_0.leftPageOnClick, arg_10_0)
	arg_10_0._rightArrowClick:AddClickListener(arg_10_0.rightPageOnClick, arg_10_0)
	arg_10_0._coverRightArrowClick:AddClickListener(arg_10_0.rightPageOnClick, arg_10_0)

	arg_10_0.currentPage = 1
	arg_10_0.maxPage = 1
	arg_10_0.startDragPosX = 0
	arg_10_0._firstPageNum = 4
	arg_10_0._isSortL2H = false
	arg_10_0._dmgFilterCount = 0
	arg_10_0._careerFilterCount = 0
	arg_10_0._locationFilterCount = 0
	arg_10_0._selectDmgs = {
		false,
		false
	}
	arg_10_0._selectCareers = {
		false,
		false,
		false,
		false,
		false,
		false
	}
	arg_10_0._selectLocations = {
		false,
		false,
		false,
		false,
		false,
		false
	}

	arg_10_0._simagebg:LoadImage(ResUrl.getHandbookCharacterIcon("full/bg111"))
	arg_10_0._simageline:LoadImage(ResUrl.getHandbookCharacterIcon("bg_xian"))
	arg_10_0._simagecoverbg2:LoadImage(ResUrl.getHandbookCharacterIcon("zhi2"))
	arg_10_0._simagecoverbg1peper1:LoadImage(ResUrl.getHandbookCharacterIcon("peper_01"))
	arg_10_0._simagecoverbg1peper2:LoadImage(ResUrl.getHandbookCharacterIcon("peper_02"))
end

function var_0_0.characterOnClick(arg_11_0, arg_11_1)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Player_Interface_Open)

	local var_11_0 = (arg_11_0.currentPage - 2) * 7 + arg_11_0:getFirstPageHeroNum()
	local var_11_1 = arg_11_0.configHeroList[var_11_0 + arg_11_1]

	if not var_11_1 then
		return
	end

	local var_11_2 = var_11_1.id
	local var_11_3 = HeroModel.instance:getByHeroId(var_11_2)

	if arg_11_0:_isAllHeroType() then
		local var_11_4 = {
			heroId = var_11_2,
			skinId = var_11_1.skinId
		}

		if not var_11_3 then
			var_11_4.skinColorStr = "#1A1A1A"
		end

		ViewMgr.instance:openView(ViewName.SummonHeroDetailView, var_11_4)
	elseif var_11_3 then
		arg_11_0:openCharacterView(var_11_2)
	else
		GameFacade.showToast(ToastEnum.HandBook1)
	end

	if var_11_3 and not HandbookModel.instance:isRead(HandbookEnum.Type.Character, var_11_2) then
		HandbookRpc.instance:sendHandbookReadRequest(HandbookEnum.Type.Character, var_11_2)

		if arg_11_0.currentPage == 1 and not arg_11_0:_isAllHeroType() then
			gohelper.setActive(arg_11_0.coveritems[arg_11_1 - 3].gonew, false)
		else
			gohelper.setActive(arg_11_0.items[arg_11_1].gonew, false)
		end
	end
end

function var_0_0.openCharacterView(arg_12_0, arg_12_1)
	CharacterController.instance:openCharacterDataView({
		fromHandbookView = true,
		heroId = arg_12_1
	})
end

function var_0_0.onUpdateParam(arg_13_0)
	return
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0:addEventCb(HandbookController.instance, HandbookController.EventName.OnShowSubCharacterView, arg_14_0.reallyOpenView, arg_14_0)
	arg_14_0:addEventCb(HandbookController.instance, HandbookController.EventName.PlayCharacterSwitchCloseAnim, arg_14_0._playCloseViewAnim, arg_14_0)
	arg_14_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, arg_14_0._onCloseFullView, arg_14_0, LuaEventSystem.Low)
	arg_14_0:addEventCb(CharacterController.instance, CharacterEvent.FilterBackpack, arg_14_0._onFilterList, arg_14_0)
end

function var_0_0.findItemSubNodes(arg_15_0, arg_15_1)
	local var_15_0 = gohelper.clone(arg_15_0._gocharacteritem, arg_15_1)

	gohelper.setActive(var_15_0, true)

	local var_15_1 = {
		gohero = gohelper.findChild(var_15_0, "hero"),
		gonohero = gohelper.findChild(var_15_0, "nohero"),
		goempty = gohelper.findChild(var_15_0, "#go_empty"),
		gocircle = gohelper.findChild(var_15_0, "circle"),
		simagehero = gohelper.findChildSingleImage(var_15_0, "hero/simage_hero"),
		simagesignature = gohelper.findChildSingleImage(var_15_0, "hero/simage_signature"),
		careerIcon = gohelper.findChildImage(var_15_0, "hero/image_career"),
		gonew = gohelper.findChild(var_15_0, "hero/go_new"),
		txtname = gohelper.findChildTextMesh(var_15_0, "hero/txt_name"),
		gostars = {}
	}

	for iter_15_0 = 1, 6 do
		table.insert(var_15_1.gostars, gohelper.findChild(var_15_0, "hero/star/star" .. iter_15_0))
	end

	var_15_1.simagenohero = gohelper.findChildSingleImage(var_15_0, "nohero/simage_nohero")
	var_15_1.txtnoheroname = gohelper.findChildTextMesh(var_15_0, "nohero/txt_noheroname")

	gohelper.setActive(var_15_1.gonew, false)

	return var_15_1
end

function var_0_0._onCloseFullView(arg_16_0)
	if arg_16_0.currentPage == 1 then
		arg_16_0._coverAnim:Play(UIAnimationName.Open, 0, 0)
	end

	arg_16_0._containerAnim:Play(UIAnimationName.Open)
end

function var_0_0.leftPageOnClick(arg_17_0)
	if arg_17_0.currentPage > 1 then
		UIBlockMgr.instance:startBlock(var_0_0.AnimatorBlockName)
		arg_17_0._containerAnim:Play("right_out", function(arg_18_0)
			arg_18_0:refreshCharacterBook(arg_18_0.currentPage - 1)
			arg_18_0._containerAnim:Play("right_in")
			UIBlockMgr.instance:endBlock(var_0_0.AnimatorBlockName)
		end, arg_17_0)
	end
end

function var_0_0.rightPageOnClick(arg_19_0)
	if arg_19_0.currentPage < arg_19_0.maxPage then
		UIBlockMgr.instance:startBlock(var_0_0.AnimatorBlockName)
		arg_19_0._containerAnim:Play("left_out", function(arg_20_0)
			arg_20_0:refreshCharacterBook(arg_20_0.currentPage + 1)
			arg_20_0._containerAnim:Play("left_in")
			UIBlockMgr.instance:endBlock(var_0_0.AnimatorBlockName)
		end, arg_19_0)
	end
end

function var_0_0.reallyOpenView(arg_21_0, arg_21_1)
	arg_21_0.heroType = arg_21_1

	arg_21_0:refreshHumanTip()
	arg_21_0:_resetFilterParam()

	arg_21_0.configHeroList = arg_21_0:_getConfigHeroList()
	arg_21_0.maxPage = arg_21_0:calculateMaxPageNum()

	arg_21_0:refreshCharacterBook(1)
	arg_21_0:refreshCoverInfo()

	arg_21_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_21_0._goContainer)

	arg_21_0._drag:AddDragBeginListener(arg_21_0.onDragBeginHandle, arg_21_0)
	arg_21_0._drag:AddDragEndListener(arg_21_0.onDragEndHandle, arg_21_0)
	arg_21_0._coverAnim:Play(UIAnimationName.Open, 0, 0)
	arg_21_0._gohumantipAnimtor:Play(UIAnimationName.Open, 0, 0)
	arg_21_0:_refreshFilterState()
end

function var_0_0.refreshHumanTip(arg_22_0)
	gohelper.setActive(arg_22_0._gohumantip, arg_22_0.heroType == 6)
	gohelper.setActive(arg_22_0._gohumansubtip, false)
	gohelper.setActive(arg_22_0._gotipclose, false)
end

function var_0_0._resetFilterParam(arg_23_0)
	arg_23_0:_resetFilterList(arg_23_0._selectDmgs)
	arg_23_0:_resetFilterList(arg_23_0._selectCareers)
	arg_23_0:_resetFilterList(arg_23_0._selectLocations)

	arg_23_0._dmgFilterCount = 0
	arg_23_0._careerFilterCount = 0
	arg_23_0._locationFilterCount = 0
	arg_23_0._isSortL2H = false
end

function var_0_0._resetFilterList(arg_24_0, arg_24_1)
	for iter_24_0 = 1, #arg_24_1 do
		arg_24_1[iter_24_0] = false
	end
end

function var_0_0._refreshShowFirstPage(arg_25_0)
	arg_25_0.configHeroList = arg_25_0:_getConfigHeroList()
	arg_25_0.maxPage = arg_25_0:calculateMaxPageNum()

	arg_25_0:refreshCharacterBook(1)
	arg_25_0:refreshCoverInfo()
end

function var_0_0._refreshFilterState(arg_26_0)
	if arg_26_0:_isAllHeroType() then
		local var_26_0 = arg_26_0._dmgFilterCount > 0 or arg_26_0._careerFilterCount > 0 or arg_26_0._locationFilterCount > 0

		gohelper.setActive(arg_26_0._goFiltering, var_26_0)
		gohelper.setActive(arg_26_0._goFilterno, not var_26_0)
		transformhelper.setLocalScale(arg_26_0._goarrowTrs, 1, arg_26_0._isSortL2H and -1 or 1, 1)
	end
end

function var_0_0._getConfigHeroList(arg_27_0)
	local var_27_0 = {}
	local var_27_1 = var_0_0._sortFuncH2L
	local var_27_2 = HeroConfig.instance:getHeroesList()

	for iter_27_0, iter_27_1 in ipairs(var_27_2) do
		if arg_27_0:_checkConfig(iter_27_1) then
			table.insert(var_27_0, iter_27_1)
		end
	end

	if arg_27_0:_isAllHeroType() and arg_27_0._isSortL2H then
		var_27_1 = var_0_0._sortFuncL2H
	end

	table.sort(var_27_0, var_27_1)

	return var_27_0
end

function var_0_0._checkConfig(arg_28_0, arg_28_1)
	if arg_28_1.stat == CharacterEnum.StatType.NotStat and not HeroModel.instance:getByHeroId(arg_28_1.id) then
		return false
	end

	if not arg_28_0:_isAllHeroType() then
		return arg_28_1.heroType == arg_28_0.heroType
	end

	local var_28_0 = {
		101,
		102,
		103,
		104,
		106,
		107
	}

	if (arg_28_0._dmgFilterCount == 0 or arg_28_0._selectDmgs[arg_28_1.dmgType]) and (arg_28_0._careerFilterCount == 0 or arg_28_0._selectCareers[arg_28_1.career]) then
		if arg_28_0._locationFilterCount == 0 then
			return true
		end

		local var_28_1 = string.splitToNumber(arg_28_1.battleTag, "#")

		for iter_28_0, iter_28_1 in ipairs(var_28_0) do
			for iter_28_2, iter_28_3 in pairs(var_28_1) do
				if arg_28_0._selectLocations[iter_28_0] and iter_28_3 == iter_28_1 then
					return true
				end
			end
		end
	end

	return false
end

function var_0_0._sortFuncH2L(arg_29_0, arg_29_1)
	if arg_29_0.rare ~= arg_29_1.rare then
		return arg_29_0.rare > arg_29_1.rare
	else
		return arg_29_0.id < arg_29_1.id
	end
end

function var_0_0._sortFuncL2H(arg_30_0, arg_30_1)
	if arg_30_0.rare ~= arg_30_1.rare then
		return arg_30_0.rare < arg_30_1.rare
	else
		return arg_30_0.id < arg_30_1.id
	end
end

function var_0_0.refreshCoverInfo(arg_31_0)
	local var_31_0 = not arg_31_0:_isAllHeroType()

	gohelper.setActive(arg_31_0._txttitleName, var_31_0)
	gohelper.setActive(arg_31_0._simagecovericon, var_31_0)

	if var_31_0 then
		local var_31_1 = lua_handbook_character.configDict[arg_31_0.heroType]

		arg_31_0._txttitleName.text = var_31_1.name

		arg_31_0._simagecovericon:LoadImage(ResUrl.getHandbookCharacterIcon("coer" .. var_31_1.icon))
	end
end

function var_0_0.refreshCharacterBook(arg_32_0, arg_32_1)
	if arg_32_1 > arg_32_0.maxPage then
		arg_32_1 = arg_32_0.maxPage
	end

	if arg_32_1 < 1 then
		arg_32_1 = 1
	end

	arg_32_0.currentPage = arg_32_1

	if arg_32_1 == 1 then
		local var_32_0 = arg_32_0:getFirstPageLeftHeroNum()

		gohelper.setActive(arg_32_0._gocover, true)
		gohelper.setActive(arg_32_0._simagepagebg.gameObject, false)
		gohelper.setActive(arg_32_0._goleftpage, var_32_0 > 0)
		gohelper.setActive(arg_32_0._gorightpage, false)

		for iter_32_0 = 1, 4 do
			arg_32_0:showBookItem(arg_32_0.coveritems[iter_32_0], arg_32_0.configHeroList[iter_32_0 + var_32_0], iter_32_0 + 3, true)
		end

		for iter_32_1 = 1, var_32_0 do
			arg_32_0:showBookItem(arg_32_0.items[iter_32_1], arg_32_0.configHeroList[iter_32_1], iter_32_1, false)
		end
	else
		gohelper.setActive(arg_32_0._gocover, false)
		gohelper.setActive(arg_32_0._simagepagebg.gameObject, true)
		gohelper.setActive(arg_32_0._goleftpage, true)
		gohelper.setActive(arg_32_0._gorightpage, true)

		local var_32_1 = (arg_32_1 - 2) * 7 + arg_32_0:getFirstPageHeroNum()

		for iter_32_2 = 1, 7 do
			arg_32_0:showBookItem(arg_32_0.items[iter_32_2], arg_32_0.configHeroList[var_32_1 + iter_32_2], iter_32_2, false)
		end
	end

	gohelper.setActive(arg_32_0._goleftarrow, arg_32_0.currentPage > 1)
	gohelper.setActive(arg_32_0._gorightarrow, arg_32_0.currentPage < arg_32_0.maxPage)
	gohelper.setActive(arg_32_0._gocoverrightarrow, arg_32_0.currentPage < arg_32_0.maxPage)
	gohelper.setActive(arg_32_0._txtpagecount, arg_32_0:_isAllHeroType())

	if arg_32_0:_isAllHeroType() then
		arg_32_0._txtpagecount.text = arg_32_0.currentPage .. "/" .. arg_32_0.maxPage
	end
end

local var_0_1 = {
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

function var_0_0.showBookItem(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	local var_33_0 = arg_33_0:_isAllHeroType()

	if arg_33_4 then
		gohelper.setActive(arg_33_0["_gocorvercharacter" .. arg_33_3], var_33_0 or arg_33_2)
	else
		gohelper.setActive(arg_33_0["_gocharacter" .. arg_33_3], var_33_0 or arg_33_2)
	end

	if arg_33_2 then
		local var_33_1 = HeroModel.instance:getByHeroId(arg_33_2.id) and true or false
		local var_33_2 = var_33_1 or var_33_0

		gohelper.setActive(arg_33_1.gohero, var_33_2)
		gohelper.setActive(arg_33_1.gonohero, not var_33_1)
		gohelper.setActive(arg_33_1.simagehero, var_33_1)

		if var_33_1 then
			arg_33_1.simagehero:LoadImage(ResUrl.getHandbookheroIcon(arg_33_2.skinId))
		else
			arg_33_1.simagenohero:LoadImage(ResUrl.getHandbookheroIcon(arg_33_2.skinId))
			gohelper.setActive(arg_33_1.txtnoheroname, not var_33_2)
		end

		if var_33_2 then
			arg_33_1.simagesignature:LoadImage(ResUrl.getSignature(arg_33_2.signature))
			UISpriteSetMgr.instance:setCommonSprite(arg_33_1.careerIcon, "lssx_" .. tostring(arg_33_2.career))

			local var_33_3 = LangSettings.instance:getCurLangShortcut()

			for iter_33_0 = 1, 6 do
				gohelper.setActive(arg_33_1.gostars[iter_33_0], iter_33_0 <= arg_33_2.rare + 1)
			end

			if arg_33_3 == 5 or arg_33_3 == 7 then
				local var_33_4 = var_0_1[var_33_3]

				if var_33_4 then
					local var_33_5 = arg_33_1.txtname:GetComponent(typeof(TMPro.TextMeshProUGUI))

					recthelper.setWidth(arg_33_1.txtname.transform, var_33_4.transformWidth)
					recthelper.setAnchorX(arg_33_1.txtname.transform, var_33_4.transformAnchorX)

					if var_33_5 then
						var_33_5.enableAutoSizing = var_33_4.enableAutoSizing
						var_33_5.fontSizeMin = var_33_4.fontSizeMin
						var_33_5.fontSizeMax = var_33_4.fontSizeMax
						arg_33_1.txtname.characterSpacing = var_33_4.characterSpacing
					end
				end
			end

			arg_33_1.txtname.text = arg_33_2.name
		end
	else
		gohelper.setActive(arg_33_1.gohero, false)
		gohelper.setActive(arg_33_1.gonohero, false)
	end

	gohelper.setActive(arg_33_1.gocircle, arg_33_2)
	gohelper.setActive(arg_33_1.goempty, var_33_0 and not arg_33_2)
end

function var_0_0.calculateMaxPageNum(arg_34_0)
	return math.ceil((#arg_34_0.configHeroList - arg_34_0:getFirstPageHeroNum()) / 7) + 1
end

function var_0_0.getFirstPageLeftHeroNum(arg_35_0)
	return math.max(0, arg_35_0:getFirstPageHeroNum() - 4)
end

function var_0_0.getFirstPageHeroNum(arg_36_0)
	if arg_36_0:_isAllHeroType() then
		return 7
	end

	return 4
end

function var_0_0._isAllHeroType(arg_37_0)
	return arg_37_0.heroType == HandbookEnum.HeroType.AllHero
end

function var_0_0.onDragBeginHandle(arg_38_0, arg_38_1, arg_38_2)
	arg_38_0.startDragPosX = arg_38_2.position.x
end

function var_0_0.onDragEndHandle(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = arg_39_2.position.x

	if math.abs(var_39_0 - arg_39_0.startDragPosX) > var_0_0.DragAbsPositionX then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_screenplay_photo_click)

		if var_39_0 < arg_39_0.startDragPosX then
			arg_39_0:rightPageOnClick()
		else
			arg_39_0:leftPageOnClick()
		end
	end
end

function var_0_0._playCloseViewAnim(arg_40_0)
	if arg_40_0.currentPage == 1 then
		arg_40_0._coverAnim:Play(UIAnimationName.Close, 0, 0)
	end

	arg_40_0._containerAnim:Play(UIAnimationName.Close)
	arg_40_0._gohumantipAnimtor:Play(UIAnimationName.Close)
	gohelper.setActive(arg_40_0._gohumansubtip, false)
	gohelper.setActive(arg_40_0._gotipclose, false)
end

function var_0_0.onClose(arg_41_0)
	arg_41_0._simagebg:UnLoadImage()
	arg_41_0._simageline:UnLoadImage()
	arg_41_0._simagecoverbg2:UnLoadImage()
	arg_41_0._simagecoverbg1peper1:UnLoadImage()
	arg_41_0._simagecoverbg1peper1:UnLoadImage()
end

function var_0_0.onDestroyView(arg_42_0)
	arg_42_0._leftArrowClick:RemoveClickListener()
	arg_42_0._rightArrowClick:RemoveClickListener()
	arg_42_0._coverRightArrowClick:RemoveClickListener()

	for iter_42_0, iter_42_1 in ipairs(arg_42_0.characterClickTabs) do
		iter_42_1:RemoveClickListener()
	end

	if arg_42_0._drag then
		arg_42_0._drag:RemoveDragBeginListener()
		arg_42_0._drag:RemoveDragEndListener()
	end

	arg_42_0:removeEventCb(HandbookController.instance, HandbookController.EventName.OnShowSubCharacterView, arg_42_0.reallyOpenView, arg_42_0)
	arg_42_0:removeEventCb(HandbookController.instance, HandbookController.EventName.PlayCharacterSwitchCloseAnim, arg_42_0._playCloseViewAnim, arg_42_0)
	arg_42_0:removeEventCb(CharacterController.instance, CharacterEvent.FilterBackpack, arg_42_0._onFilterList, arg_42_0)
	arg_42_0._simagecovericon:UnLoadImage()
end

return var_0_0
