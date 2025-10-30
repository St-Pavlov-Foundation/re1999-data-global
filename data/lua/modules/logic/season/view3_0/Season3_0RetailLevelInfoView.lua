module("modules.logic.season.view3_0.Season3_0RetailLevelInfoView", package.seeall)

local var_0_0 = class("Season3_0RetailLevelInfoView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageuppermask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_uppermask")
	arg_1_0._btnclose1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close1")
	arg_1_0._btnclose2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close2")
	arg_1_0._gobottom = gohelper.findChild(arg_1_0.viewGO, "bottom")
	arg_1_0._gonormalcondition = gohelper.findChild(arg_1_0.viewGO, "bottom/#go_conditions/#go_normalcondition")
	arg_1_0._txtnormalrule = gohelper.findChildText(arg_1_0.viewGO, "bottom/#go_conditions/#go_normalcondition/#txt_normalrule")
	arg_1_0._gospecialcondition = gohelper.findChild(arg_1_0.viewGO, "bottom/#go_conditions/#go_specialcondition")
	arg_1_0._txtspecialrule = gohelper.findChildText(arg_1_0.viewGO, "bottom/#go_conditions/#go_specialcondition/#txt_specialrule")
	arg_1_0._txtlevelname = gohelper.findChildText(arg_1_0.viewGO, "bottom/#txt_levelname")
	arg_1_0._txtenemylevelnum = gohelper.findChildText(arg_1_0.viewGO, "bottom/txt_enemylevel/#txt_enemylevelnum")
	arg_1_0._scrollcelebritycard = gohelper.findChildScrollRect(arg_1_0.viewGO, "bottom/rewards/rewardlist/#scroll_celebritycard")
	arg_1_0._gocarditem = gohelper.findChild(arg_1_0.viewGO, "bottom/rewards/rewardlist/#scroll_celebritycard/scrollcontent_seasoncelebritycarditem")
	arg_1_0._txtdecr = gohelper.findChildText(arg_1_0.viewGO, "bottom/#txt_decr")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/#btn_close")
	arg_1_0._btnstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/#btn_start")
	arg_1_0._gotag = gohelper.findChild(arg_1_0.viewGO, "bottom/#go_tag")
	arg_1_0._txttagdesc = gohelper.findChildText(arg_1_0.viewGO, "bottom/#go_tag/descbg/#txt_tagdesc")
	arg_1_0._gostage = gohelper.findChild(arg_1_0.viewGO, "bottom/stages")
	arg_1_0._gostageitem = gohelper.findChild(arg_1_0.viewGO, "bottom/stages/#go_stageitem")
	arg_1_0._simageleftbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_leftbg")
	arg_1_0._simagerightbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_rightbg")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose1:AddClickListener(arg_2_0._btnclose1OnClick, arg_2_0)
	arg_2_0._btnclose2:AddClickListener(arg_2_0._btnclose2OnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnstart:AddClickListener(arg_2_0._btnstartOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose1:RemoveClickListener()
	arg_3_0._btnclose2:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnstart:RemoveClickListener()
end

function var_0_0._btnclose1OnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnclose2OnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._btncloseOnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._btnstartOnClick(arg_7_0)
	Activity104Model.instance:enterAct104Battle(arg_7_0.retailInfo.id, 0)
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._simageuppermask:LoadImage(SeasonViewHelper.getSeasonIcon("full/seasonsecretlandentrance_mask.png"))
	arg_8_0._simageleftbg:LoadImage(SeasonViewHelper.getSeasonIcon("msg_xia.png"))
	arg_8_0._simagerightbg:LoadImage(SeasonViewHelper.getSeasonIcon("msg_shang.png"))
end

function var_0_0.onUpdateParam(arg_9_0)
	arg_9_0:refreshParam()
	arg_9_0:_setInfo()
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:refreshParam()
	arg_10_0:_setInfo()
end

function var_0_0.refreshParam(arg_11_0)
	arg_11_0.retailInfo = arg_11_0.viewParam.retail
end

local var_0_1 = {
	targetFlagUIPosX = -32.7,
	targetFlagUIScale = 2.3,
	targetFlagUIPosY = 28.3
}

function var_0_0._setInfo(arg_12_0)
	if not arg_12_0.retailInfo then
		return
	end

	Activity104Controller.instance:dispatchEvent(Activity104Event.SelectRetail, arg_12_0.retailInfo.position)

	local var_12_0 = Activity104Model.instance:getCurSeasonId()
	local var_12_1 = SeasonConfig.instance:getSeasonRetailEpisodeCo(var_12_0, arg_12_0.retailInfo.id)

	arg_12_0._txtlevelname.text = var_12_1.desc
	arg_12_0._txtenemylevelnum.text = HeroConfig.instance:getCommonLevelDisplay(var_12_1.level)

	gohelper.setActive(arg_12_0._gotag, false)

	if not arg_12_0._cardItems then
		arg_12_0._cardItems = {}
	end

	for iter_12_0, iter_12_1 in pairs(arg_12_0._cardItems) do
		gohelper.setActive(iter_12_1.go, false)
	end

	for iter_12_2 = 1, #arg_12_0.retailInfo.showActivity104EquipIds do
		local var_12_2 = arg_12_0.retailInfo.showActivity104EquipIds[iter_12_2]

		if not arg_12_0._cardItems[iter_12_2] then
			arg_12_0._cardItems[iter_12_2] = Season3_0CelebrityCardItem.New()

			arg_12_0._cardItems[iter_12_2]:init(arg_12_0._gocarditem, var_12_2, var_0_1)
		else
			gohelper.setActive(arg_12_0._cardItems[iter_12_2].go, true)
			arg_12_0._cardItems[iter_12_2]:reset(var_12_2)
		end

		arg_12_0._cardItems[iter_12_2]:showTag(true)
		arg_12_0._cardItems[iter_12_2]:showProbability(true)
	end

	local var_12_3 = arg_12_0.retailInfo.advancedId
	local var_12_4 = arg_12_0.retailInfo.advancedRare

	gohelper.setActive(arg_12_0._gonormalcondition, var_12_3 ~= 0 and var_12_4 == 1)
	gohelper.setActive(arg_12_0._gospecialcondition, var_12_3 ~= 0 and var_12_4 == 2)

	if var_12_3 ~= 0 then
		local var_12_5 = "      " .. lua_condition.configDict[var_12_3].desc

		if var_12_4 == 1 then
			arg_12_0._txtnormalrule.text = var_12_5
		elseif var_12_4 == 2 then
			arg_12_0._txtspecialrule.text = var_12_5
		end
	end

	arg_12_0:_refreshStateUI()
end

function var_0_0._refreshStateUI(arg_13_0)
	local var_13_0 = Activity104Model.instance:getAct104CurStage()
	local var_13_1 = Activity104Model.instance:getMaxStage()

	if not arg_13_0.starComp then
		arg_13_0.starComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_13_0._gostage, SeasonStarProgressComp)
	end

	arg_13_0.starComp:refreshStar(arg_13_0._gostageitem, var_13_0, var_13_1)
end

function var_0_0.onClose(arg_14_0)
	Activity104Controller.instance:dispatchEvent(Activity104Event.SelectRetail)
end

function var_0_0.onDestroyView(arg_15_0)
	if arg_15_0._cardItems then
		for iter_15_0, iter_15_1 in pairs(arg_15_0._cardItems) do
			iter_15_1:destroy()
		end

		arg_15_0._cardItems = nil
	end

	arg_15_0._simageuppermask:UnLoadImage()
	arg_15_0._simageleftbg:UnLoadImage()
	arg_15_0._simagerightbg:UnLoadImage()
end

return var_0_0
