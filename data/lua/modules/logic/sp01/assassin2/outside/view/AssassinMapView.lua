module("modules.logic.sp01.assassin2.outside.view.AssassinMapView", package.seeall)

local var_0_0 = class("AssassinMapView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_task", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_1_0._gotaskreddot = gohelper.findChild(arg_1_0.viewGO, "root/#btn_task/#go_taskreddot")
	arg_1_0._btndevelop = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_develop", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_1_0._btnlibrary = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_library", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_1_0._golibraryreddot = gohelper.findChild(arg_1_0.viewGO, "root/#btn_library/#go_libraryreddot")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntask:AddClickListener(arg_2_0._btntaskOnClick, arg_2_0)
	arg_2_0._btndevelop:AddClickListener(arg_2_0._btndevelopOnClick, arg_2_0)
	arg_2_0._btnlibrary:AddClickListener(arg_2_0._btnlibraryOnClick, arg_2_0)
	arg_2_0:addEventCb(AssassinController.instance, AssassinEvent.UpdateLibraryReddot, arg_2_0.initLibraryRedDot, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntask:RemoveClickListener()
	arg_3_0._btndevelop:RemoveClickListener()
	arg_3_0._btnlibrary:RemoveClickListener()
end

function var_0_0._btntaskOnClick(arg_4_0)
	AssassinController.instance:openAssassinTaskView()
end

function var_0_0._btndevelopOnClick(arg_5_0)
	AssassinController.instance:openAssassinHeroView()
end

function var_0_0._btnlibraryOnClick(arg_6_0)
	AssassinController.instance:openAssassinLibraryView()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0:initHomeEntrance()
	arg_7_0:initMapEntrances()
	arg_7_0:initLibraryRedDot()
	RedDotController.instance:addRedDot(arg_7_0._gotaskreddot, RedDotEnum.DotNode.AssassinOutsideTask)
end

function var_0_0.initHomeEntrance(arg_8_0)
	local var_8_0 = gohelper.findChild(arg_8_0.viewGO, "root/#go_home")

	arg_8_0:openSubView(AssassinBuildingMapEntrance, var_8_0, arg_8_0.viewGO)
end

function var_0_0.initMapEntrances(arg_9_0)
	local var_9_0 = AssassinConfig.instance:getMapIdList()

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		local var_9_1 = gohelper.findChild(arg_9_0.viewGO, "root/#go_maps/#go_pos" .. iter_9_1)

		if gohelper.isNil(var_9_1) then
			logError(string.format("AssassinMapView:initMapEntrances error, go not enough mapId：%s", iter_9_1))
		else
			arg_9_0:openSubView(AssassinQuestMapEntrance, var_9_1, arg_9_0.viewGO, iter_9_1)
		end
	end
end

function var_0_0.initLibraryRedDot(arg_10_0)
	arg_10_0._libraryRedDot = RedDotController.instance:addNotEventRedDot(arg_10_0._golibraryreddot, arg_10_0._libraryRedDotCheckFunc, arg_10_0, AssassinEnum.LibraryReddotStyle)

	arg_10_0._libraryRedDot:refreshRedDot()
end

function var_0_0._libraryRedDotCheckFunc(arg_11_0)
	return AssassinLibraryModel.instance:isAnyLibraryNewUnlock()
end

function var_0_0.onOpen(arg_12_0)
	return
end

function var_0_0.onClose(arg_13_0)
	return
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

return var_0_0
