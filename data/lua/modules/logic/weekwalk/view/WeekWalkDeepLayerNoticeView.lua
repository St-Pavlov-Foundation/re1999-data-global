module("modules.logic.weekwalk.view.WeekWalkDeepLayerNoticeView", package.seeall)

local var_0_0 = class("WeekWalkDeepLayerNoticeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg1")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._simagemask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_mask")
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg2")
	arg_1_0._txtlastprogress = gohelper.findChildText(arg_1_0.viewGO, "rule/#txt_lastprogress")
	arg_1_0._imageruleicon = gohelper.findChildImage(arg_1_0.viewGO, "rule/ruleinfo/#image_ruleicon")
	arg_1_0._imageruletag = gohelper.findChildImage(arg_1_0.viewGO, "rule/ruleinfo/#image_ruletag")
	arg_1_0._txtruledesc = gohelper.findChildText(arg_1_0.viewGO, "rule/ruleinfo/#txt_ruledesc")
	arg_1_0._simageruledescicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "rule/ruleinfo/mask/#simage_ruledescicon")
	arg_1_0._scrollrewards = gohelper.findChildScrollRect(arg_1_0.viewGO, "rewards/#scroll_rewards")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "rewards/#scroll_rewards/Viewport/Content/#go_rewarditem")
	arg_1_0._btnstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rewards/#btn_start")
	arg_1_0._btnruledetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rule/ruleinfo/#btn_ruledetail")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnstart:AddClickListener(arg_2_0._btnstartOnClick, arg_2_0)
	arg_2_0._btnruledetail:AddClickListener(arg_2_0._btnruledetailOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnstart:RemoveClickListener()
	arg_3_0._btnruledetail:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnstartOnClick(arg_5_0)
	arg_5_0:openWeekWalkView()
end

function var_0_0._btnruledetailOnClick(arg_6_0)
	WeekWalkController.instance:openWeekWalkRuleView()
end

function var_0_0.openWeekWalkView(arg_7_0)
	module_views_preloader.WeekWalkLayerViewPreload(function()
		arg_7_0:delayOpenWeekWalkView()
	end)
end

function var_0_0.delayOpenWeekWalkView(arg_9_0)
	arg_9_0:closeThis()
	WeekWalkController.instance:openWeekWalkLayerView()
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0._info = WeekWalkModel.instance:getInfo()

	if arg_10_0._info.isPopDeepSettle then
		arg_10_0._info.isPopDeepSettle = false

		WeekwalkRpc.instance:sendMarkPopDeepSettleRequest()
	end

	arg_10_0._simagebg1:LoadImage(ResUrl.getWeekWalkBg("full/beijing_shen.jpg"))
	arg_10_0._simagemask:LoadImage(ResUrl.getWeekWalkBg("zhezhao.png"))
	arg_10_0._simagebg2:LoadImage(ResUrl.getWeekWalkBg("shenmian_tcdi.png"))
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0._getRewardList(arg_12_0)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(lua_task_weekwalk.configList) do
		if iter_12_1.minTypeId == 4 and WeekWalkTaskListModel.instance:checkPeriods(iter_12_1) then
			local var_12_1 = GameUtil.splitString2(iter_12_1.bonus, true, "|", "#")

			for iter_12_2, iter_12_3 in ipairs(var_12_1) do
				local var_12_2 = iter_12_3[1]
				local var_12_3 = iter_12_3[2]
				local var_12_4 = iter_12_3[3]
				local var_12_5 = string.format("%s_%s", var_12_2, var_12_3)
				local var_12_6 = var_12_0[var_12_5]

				if not var_12_6 then
					var_12_0[var_12_5] = iter_12_3
				else
					var_12_6[3] = var_12_6[3] + var_12_4
					var_12_0[var_12_5] = var_12_6
				end
			end
		end
	end

	local var_12_7 = {}

	for iter_12_4, iter_12_5 in pairs(var_12_0) do
		table.insert(var_12_7, iter_12_5)
	end

	table.sort(var_12_7, DungeonWeekWalkView._sort)

	return var_12_7
end

function var_0_0._showRewardList(arg_13_0)
	local var_13_0 = arg_13_0:_getRewardList()

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		local var_13_1 = gohelper.cloneInPlace(arg_13_0._gorewarditem)

		gohelper.setActive(var_13_1, true)

		local var_13_2 = IconMgr.instance:getCommonItemIcon(gohelper.findChild(var_13_1, "go_item"))

		var_13_2:setMOValue(iter_13_1[1], iter_13_1[2], iter_13_1[3])
		var_13_2:isShowCount(true)
		var_13_2:setCountFontSize(31)
	end
end

function var_0_0.onOpen(arg_14_0)
	if arg_14_0.viewParam and arg_14_0.viewParam.openFromGuide then
		gohelper.findChildText(arg_14_0.viewGO, "rule/resettip").text = luaLang("p_weekwalkdeeplayernoticeview_title_open")

		local var_14_0 = gohelper.findChild(arg_14_0.viewGO, "rewards")

		recthelper.setAnchorY(var_14_0.transform, -208)
		gohelper.setActive(arg_14_0._txtlastprogress, false)
	end

	local var_14_1 = arg_14_0._info.deepProgress
	local var_14_2 = string.splitToNumber(var_14_1, "#")
	local var_14_3 = var_14_2[1]
	local var_14_4 = var_14_2[2]

	if var_14_3 and var_14_4 then
		local var_14_5 = lua_weekwalk.configDict[var_14_3]
		local var_14_6 = lua_weekwalk_scene.configDict[var_14_5.sceneId]
		local var_14_7 = {
			var_14_6.name,
			"0" .. (var_14_4 or 1)
		}

		arg_14_0._txtlastprogress.text = GameUtil.getSubPlaceholderLuaLang(luaLang("weekwalkdeeplayernoticeview_lastprogress"), var_14_7)
	else
		arg_14_0._txtlastprogress.text = luaLang("weekwalkdeeplayernoticeview_noprogress")
	end

	arg_14_0:_showRewardList()

	local var_14_8 = arg_14_0._info.issueId
	local var_14_9 = lua_weekwalk_rule.configDict[var_14_8]
	local var_14_10 = var_14_9.isCn == 1
	local var_14_11

	if var_14_10 then
		local var_14_12 = ResUrl.getWeekWalkIconLangPath(var_14_9.icon)
	else
		local var_14_13 = ResUrl.getWeekWalkBg("rule/" .. var_14_9.icon .. ".png")
	end

	local var_14_14 = ResUrl.getWeekWalkBg("rule/" .. var_14_9.icon .. ".png")

	arg_14_0._simageruledescicon:LoadImage(var_14_14)

	local var_14_15 = var_14_9.additionRule

	if string.nilorempty(var_14_15) then
		return
	end

	local var_14_16 = GameUtil.splitString2(var_14_15, true, "|", "#")

	arg_14_0._ruleList = var_14_16

	for iter_14_0, iter_14_1 in ipairs(var_14_16) do
		local var_14_17 = iter_14_1[1]
		local var_14_18 = iter_14_1[2]
		local var_14_19 = lua_rule.configDict[var_14_18]

		arg_14_0:_setRuleDescItem(var_14_19, var_14_17)

		break
	end

	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_ui_artificial_installation_open)
end

function var_0_0._setRuleDescItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = {
		"#6384E5",
		"#D05B4C",
		"#C7b376"
	}

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(arg_15_0._imageruleicon, arg_15_1.icon)
	UISpriteSetMgr.instance:setCommonSprite(arg_15_0._imageruletag, "wz_" .. arg_15_2)

	local var_15_1 = string.gsub(arg_15_1.desc, "%【(.-)%】", "<color=#FF906A>[%1]</color>")
	local var_15_2 = "\n" .. HeroSkillModel.instance:getEffectTagDescFromDescRecursion(arg_15_1.desc, var_15_0[1])
	local var_15_3 = luaLang("dungeon_add_rule_target_" .. arg_15_2)
	local var_15_4 = var_15_0[arg_15_2]
	local var_15_5 = var_15_1 .. var_15_2

	arg_15_0._txtruledesc.text = formatLuaLang("fight_rule_desc", var_15_4, var_15_3, var_15_5)
end

function var_0_0.onClose(arg_16_0)
	arg_16_0._simageruledescicon:UnLoadImage()
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_ui_artificial_settlement_close)
end

function var_0_0.onDestroyView(arg_17_0)
	arg_17_0._simagebg1:UnLoadImage()
	arg_17_0._simagemask:UnLoadImage()
	arg_17_0._simagebg2:UnLoadImage()
end

return var_0_0
