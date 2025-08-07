module("modules.logic.sp01.assassin2.outside.view.AssassinQuestDetailView", package.seeall)

local var_0_0 = class("AssassinQuestDetailView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goroot = gohelper.findChild(arg_1_0.viewGO, "root")
	arg_1_0._goquestItem = gohelper.findChild(arg_1_0.viewGO, "root/#go_questItem")
	arg_1_0._imagequesItem = gohelper.findChildImage(arg_1_0.viewGO, "root/#go_questItem/image_icon")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "root/#go_tips")
	arg_1_0._imagequesttype = gohelper.findChildImage(arg_1_0.viewGO, "root/#go_tips/#go_title/#img_icon")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "root/#go_tips/#go_title/#txt_title")
	arg_1_0._gopic = gohelper.findChild(arg_1_0.viewGO, "root/#go_tips/#go_pic")
	arg_1_0._simageinfo = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#go_tips/#go_pic/#simage_info")
	arg_1_0._btninfo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_tips/#go_pic/#btn_info", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "root/#go_tips/#go_desc/#scroll_desc/Viewport/Content/#txt_desc")
	arg_1_0._txtunlock = gohelper.findChildText(arg_1_0.viewGO, "root/#go_tips/#go_desc/#scroll_desc/Viewport/Content/#txt_unlock")
	arg_1_0._txtrecommend = gohelper.findChildText(arg_1_0.viewGO, "root/#go_tips/#go_desc/#scroll_desc/Viewport/Content/#txt_recommend")
	arg_1_0._goreward = gohelper.findChild(arg_1_0.viewGO, "root/#go_tips/#go_desc/#go_reward")
	arg_1_0._txtrewardnum = gohelper.findChildText(arg_1_0.viewGO, "root/#go_tips/#go_desc/#go_reward/#txt_rewardNum")
	arg_1_0._btnstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_tips/#btn_start", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_1_0._txtstart = gohelper.findChildText(arg_1_0.viewGO, "root/#go_tips/#btn_start/txt_start")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btninfo:AddClickListener(arg_2_0._btninfoOnClick, arg_2_0)
	arg_2_0._btnstart:AddClickListener(arg_2_0._btnstartOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btninfo:RemoveClickListener()
	arg_3_0._btnstart:RemoveClickListener()
end

function var_0_0._btninfoOnClick(arg_4_0)
	AssassinController.instance:openAssassinStealthGameOverView(arg_4_0._questId)
end

function var_0_0._btnstartOnClick(arg_5_0)
	AssassinController.instance:startQuest(arg_5_0._questId)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._transRoot = arg_6_0._goroot.transform
	arg_6_0._transQuestItem = arg_6_0._goquestItem.transform
	arg_6_0._transTips = arg_6_0._gotips.transform

	local var_6_0 = recthelper.getWidth(arg_6_0._transTips)

	arg_6_0._space = recthelper.getAnchorX(arg_6_0._transTips)
	arg_6_0._tipNeedWidth = arg_6_0._space + var_6_0 / 2
end

function var_0_0.onUpdateParam(arg_7_0)
	arg_7_0._questId = arg_7_0.viewParam.questId
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:onUpdateParam()
	arg_8_0:setInfo()
	arg_8_0:setQuestItem()
	AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_taskchoose)
end

function var_0_0.setInfo(arg_9_0)
	local var_9_0 = AssassinConfig.instance:getQuestType(arg_9_0._questId)

	AssassinHelper.setQuestTypeIcon(var_9_0, arg_9_0._imagequesttype)

	local var_9_1 = "p_assassinquestdetailview_txt_start"

	if var_9_0 == AssassinEnum.QuestType.Dialog then
		var_9_1 = "p_assassinquestdetailview_txt_start2"
	end

	arg_9_0._txtstart.text = luaLang(var_9_1)

	local var_9_2 = AssassinConfig.instance:getQuestName(arg_9_0._questId)

	arg_9_0._txttitle.text = var_9_2

	local var_9_3 = AssassinConfig.instance:getQuestDesc(arg_9_0._questId)

	arg_9_0._txtdesc.text = var_9_3

	local var_9_4 = AssassinConfig.instance:getQuestPicture(arg_9_0._questId)

	if string.nilorempty(var_9_4) then
		gohelper.setActive(arg_9_0._gopic, false)
	else
		local var_9_5 = ResUrl.getSp01AssassinSingleBg("map/" .. var_9_4)

		arg_9_0._simageinfo:LoadImage(var_9_5)
		gohelper.setActive(arg_9_0._gopic, true)
	end

	local var_9_6 = AssassinConfig.instance:getQuestRewardCount(arg_9_0._questId)

	arg_9_0._txtrewardnum.text = var_9_6

	gohelper.setActive(arg_9_0._goreward, var_9_6 and var_9_6 > 0)

	local var_9_7 = AssassinConfig.instance:getQuestRecommendHeroList(arg_9_0._questId)

	if var_9_7 then
		local var_9_8
		local var_9_9 = luaLang("room_levelup_init_and1")

		for iter_9_0, iter_9_1 in ipairs(var_9_7) do
			local var_9_10 = AssassinConfig.instance:getHeroCfgByAssassinHeroId(iter_9_1)

			if var_9_10 then
				if var_9_8 then
					var_9_8 = var_9_8 .. var_9_9 .. var_9_10.name
				else
					var_9_8 = var_9_10.name
				end
			end
		end

		local var_9_11 = luaLang("assassin_stealth_game_recommend_hero")

		arg_9_0._txtrecommend.text = GameUtil.getSubPlaceholderLuaLangOneParam(var_9_11, var_9_8)
	else
		gohelper.setActive(arg_9_0._txtrecommend, false)
	end

	local var_9_12 = AssassinConfig.instance:getUnlockHeroId(arg_9_0._questId)

	if var_9_12 then
		local var_9_13 = AssassinConfig.instance:getHeroCfgByAssassinHeroId(var_9_12)
		local var_9_14 = var_9_13 and var_9_13.name or ""
		local var_9_15 = luaLang("assassin_stealth_game_unlock_hero")

		arg_9_0._txtunlock.text = GameUtil.getSubPlaceholderLuaLangOneParam(var_9_15, var_9_14)
	else
		gohelper.setActive(arg_9_0._txtunlock, false)
	end

	UnityEngine.Canvas.ForceUpdateCanvases()
end

function var_0_0.setQuestItem(arg_10_0)
	local var_10_0 = AssassinConfig.instance:getQuestType(arg_10_0._questId)

	AssassinHelper.setQuestTypeIcon(var_10_0, arg_10_0._imagequesItem)

	local var_10_1 = 0
	local var_10_2 = 0
	local var_10_3 = arg_10_0.viewParam and arg_10_0.viewParam.worldPos

	if var_10_3 then
		local var_10_4 = arg_10_0._transRoot:InverseTransformPoint(var_10_3)

		var_10_1 = var_10_4.x
		var_10_2 = var_10_4.y
	end

	recthelper.setAnchor(arg_10_0._transQuestItem, var_10_1, var_10_2)

	local var_10_5, var_10_6 = GameUtil.getViewSize()
	local var_10_7 = var_10_5 / 2 - var_10_1 >= arg_10_0._tipNeedWidth and var_10_1 + arg_10_0._space or var_10_1 - arg_10_0._space
	local var_10_8 = var_10_6 / 2 - recthelper.getHeight(arg_10_0._transTips) / 2
	local var_10_9 = Mathf.Clamp(var_10_2, -var_10_8, var_10_8)

	recthelper.setAnchor(arg_10_0._transTips, var_10_7, var_10_9)
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	arg_12_0._simageinfo:UnLoadImage()
end

return var_0_0
