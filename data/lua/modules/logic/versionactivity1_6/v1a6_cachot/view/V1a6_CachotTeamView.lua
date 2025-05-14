module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotTeamView", package.seeall)

local var_0_0 = class("V1a6_CachotTeamView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotipswindow = gohelper.findChild(arg_1_0.viewGO, "#go_tipswindow")
	arg_1_0._simageselect = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_tipswindow/left/#simage_select")
	arg_1_0._gopresetcontent = gohelper.findChild(arg_1_0.viewGO, "#go_tipswindow/left/scroll_view/Viewport/#go_presetcontent")
	arg_1_0._gopreparecontent = gohelper.findChild(arg_1_0.viewGO, "#go_tipswindow/right/scroll_view/Viewport/#go_preparecontent")
	arg_1_0._gostart = gohelper.findChild(arg_1_0.viewGO, "#go_tipswindow/#go_start")
	arg_1_0._btnstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_tipswindow/#go_start/#btn_start")
	arg_1_0._gostartlight = gohelper.findChild(arg_1_0.viewGO, "#go_tipswindow/#go_start/#btn_start/#go_startlight")
	arg_1_0._imagepoint1 = gohelper.findChildImage(arg_1_0.viewGO, "#go_tipswindow/#go_start/#image_point1")
	arg_1_0._gopoin1light = gohelper.findChild(arg_1_0.viewGO, "#go_tipswindow/#go_start/#image_point1/#go_poin1_light")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_title")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnstart:AddClickListener(arg_2_0._btnstartOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnstart:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnaddheartOnClick(arg_5_0)
	return
end

function var_0_0._btnaddroleOnClick(arg_6_0)
	return
end

function var_0_0._btnstartOnClick(arg_7_0)
	local var_7_0 = {}
	local var_7_1 = {}
	local var_7_2 = arg_7_0:_getGroup(1, "", var_7_0, var_7_1, 1, V1a6_CachotEnum.HeroCountInGroup)
	local var_7_3 = arg_7_0:_getGroup(1, "", var_7_0, var_7_1, V1a6_CachotEnum.HeroCountInGroup + 1, V1a6_CachotEnum.InitTeamMaxHeroCountInGroup)

	if #var_7_0 == 0 then
		GameFacade.showToast(ToastEnum.V1a6CachotToast02)

		return
	end

	RogueRpc.instance:sendEnterRogueRequest(V1a6_CachotEnum.ActivityId, V1a6_CachotTeamModel.instance:getSelectLevel(), var_7_2, var_7_3, var_7_1)
	V1a6_CachotStatController.instance:statStart()
end

function var_0_0._getGroup(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6)
	local var_8_0 = {
		id = arg_8_1,
		groupName = arg_8_2
	}
	local var_8_1 = V1a6_CachotHeroSingleGroupModel.instance:getCurGroupMO()
	local var_8_2 = {}
	local var_8_3 = {}

	for iter_8_0 = arg_8_5, arg_8_6 do
		local var_8_4 = V1a6_CachotHeroSingleGroupModel.instance:getById(iter_8_0)
		local var_8_5 = var_8_1:getPosEquips(iter_8_0 - 1)
		local var_8_6 = tonumber(var_8_5.equipUid[1])

		if var_8_6 and var_8_6 > 0 then
			if EquipModel.instance:getEquip(var_8_5.equipUid[1]) then
				table.insert(arg_8_4, var_8_6)
			else
				var_8_5.equipUid[1] = "0"

				local var_8_7 = 0
			end
		end

		local var_8_8 = HeroModel.instance:getById(var_8_4.heroUid)
		local var_8_9 = var_8_8 and var_8_8.heroId or 0

		table.insert(var_8_2, var_8_9)
		table.insert(var_8_3, var_8_5)

		if var_8_9 > 0 then
			table.insert(arg_8_3, var_8_9)
		end
	end

	var_8_0.heroList = var_8_2
	var_8_0.equips = var_8_3

	return var_8_0
end

function var_0_0._hasSelectedHero(arg_9_0)
	for iter_9_0 = 1, V1a6_CachotEnum.InitTeamMaxHeroCountInGroup do
		local var_9_0 = V1a6_CachotHeroSingleGroupModel.instance:getById(iter_9_0)
		local var_9_1 = HeroModel.instance:getById(var_9_0.heroUid)

		if (var_9_1 and var_9_1.heroId or 0) > 0 then
			return true
		end
	end
end

function var_0_0._updateStatus(arg_10_0)
	local var_10_0 = arg_10_0:_hasSelectedHero()

	gohelper.setActive(arg_10_0._gostartlight, var_10_0)
	gohelper.setActive(arg_10_0._gopoin1light, var_10_0)

	arg_10_0._imagepoint1.enabled = not var_10_0
end

function var_0_0.onOpen(arg_11_0)
	local var_11_0 = arg_11_0.viewParam and arg_11_0.viewParam.isInitSelect

	gohelper.setActive(arg_11_0._gostart, var_11_0)
	arg_11_0:_updateStatus()
	arg_11_0:addEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.OnReceiveEnterRogueReply, arg_11_0._onReceiveEnterRogueReply, arg_11_0)
	arg_11_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_11_0._modifyHeroGroup, arg_11_0)
	NavigateMgr.instance:addEscape(ViewName.V1a6_CachotTeamView, arg_11_0._btncloseOnClick, arg_11_0)
end

function var_0_0._modifyHeroGroup(arg_12_0)
	arg_12_0:_updateStatus()
end

function var_0_0._onReceiveEnterRogueReply(arg_13_0)
	ViewMgr.instance:closeView(ViewName.V1a6_CachotMainView)
	ViewMgr.instance:closeView(ViewName.V1a6_CachotDifficultyView)
	ViewMgr.instance:closeView(ViewName.V1a6_CachotTeamView)
	V1a6_CachotController.instance:openRoom()
end

function var_0_0.onClose(arg_14_0)
	return
end

function var_0_0.onDestroyView(arg_15_0)
	return
end

return var_0_0
