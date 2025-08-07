module("modules.logic.sp01.assassin2.outside.view.AssassinBuildingMapView", package.seeall)

local var_0_0 = class("AssassinBuildingMapView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocontainer = gohelper.findChild(arg_1_0.viewGO, "root/#go_container")
	arg_1_0._gobuildingicon = gohelper.findChild(arg_1_0.viewGO, "root/#go_container/#go_buildingicon")
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/right/#btn_task", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_1_0._gotaskreddot = gohelper.findChild(arg_1_0.viewGO, "root/right/#btn_task/#go_taskreddot")
	arg_1_0._btndevelop = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/right/#btn_develop", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_1_0._txtcurrencynum = gohelper.findChildText(arg_1_0.viewGO, "root/#go_topright/go_costitem/#txt_currencynum")
	arg_1_0._gotopright = gohelper.findChild(arg_1_0.viewGO, "root/#go_topright")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntask:AddClickListener(arg_2_0._btntaskOnClick, arg_2_0)
	arg_2_0._btndevelop:AddClickListener(arg_2_0._btndevelopOnClick, arg_2_0)
	arg_2_0:addEventCb(AssassinController.instance, AssassinEvent.FocusBuilding, arg_2_0._onFocusBuilding, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntask:RemoveClickListener()
	arg_3_0._btndevelop:RemoveClickListener()
end

function var_0_0._btntaskOnClick(arg_4_0)
	AssassinController.instance:openAssassinTaskView()
end

function var_0_0._btndevelopOnClick(arg_5_0)
	AssassinController.instance:openAssassinHeroView()
end

function var_0_0._editableInitView(arg_6_0)
	RedDotController.instance:addRedDot(arg_6_0._gotaskreddot, RedDotEnum.DotNode.AssassinOutsideTask)
	gohelper.setActive(arg_6_0._gobuildingicon, false)

	arg_6_0._animator = gohelper.onceAddComponent(arg_6_0.viewGO, gohelper.Type_Animator)
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:openSubView(AssassinCurrencyToolView, nil, arg_7_0._gotopright)
	arg_7_0:initAllBuildings()
	AudioMgr.instance:trigger(AudioEnum2_9.Dungeon.play_ui_unlockNewEpisode)
end

function var_0_0.initAllBuildings(arg_8_0)
	local var_8_0 = arg_8_0.viewParam and arg_8_0.viewParam.buildingType

	for iter_8_0, iter_8_1 in pairs(AssassinEnum.BuildingType) do
		local var_8_1 = gohelper.findChild(arg_8_0._gocontainer, "go_pos" .. iter_8_1)

		if not gohelper.isNil(var_8_1) then
			local var_8_2 = gohelper.findChild(var_8_1, "go_posBuilding")
			local var_8_3 = gohelper.findChild(var_8_1, "go_buildingclickarea")
			local var_8_4 = gohelper.clone(arg_8_0._gobuildingicon, var_8_1, "building_" .. iter_8_1)
			local var_8_5 = MonoHelper.addNoUpdateLuaComOnceToGo(var_8_4, AssassinBuildingItemIcon)

			var_8_5:updateIconPosition(var_8_2)
			var_8_5:updateIconClickArea(var_8_3)
			var_8_5:setBuildingType(iter_8_1)

			if var_8_0 and var_8_0 == iter_8_1 then
				var_8_5:_btnclickOnClick()
			end
		else
			logError(string.format("建筑入口缺少挂点 buildingType = %s", iter_8_1))
		end
	end
end

function var_0_0._onFocusBuilding(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0._animator then
		return
	end

	local var_9_0 = ""

	if arg_9_2 then
		var_9_0 = string.format("building%02d", arg_9_1)
	else
		var_9_0 = string.format("back%02d", arg_9_1)
	end

	arg_9_0._animator:Play(var_9_0, 0, 0)
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
