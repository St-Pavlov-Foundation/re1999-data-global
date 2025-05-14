module("modules.logic.balanceumbrella.view.BalanceUmbrellaDungeonMapView", package.seeall)

local var_0_0 = class("BalanceUmbrellaDungeonMapView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnunfull = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_main/#go_rightbtns/#btn_balanceumbrella_unfull")
	arg_1_0._btnfull = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_main/#go_rightbtns/#btn_balanceumbrella_full")
	arg_1_0._effect1 = gohelper.findChild(arg_1_0.viewGO, "#go_main/#go_rightbtns/#btn_balanceumbrella_unfull/vx_get")
	arg_1_0._effect2 = gohelper.findChild(arg_1_0.viewGO, "#go_main/#go_rightbtns/#btn_balanceumbrella_full/vx_get")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnunfull:AddClickListener(arg_2_0._openBalanceUmbrellaView, arg_2_0)
	arg_2_0._btnfull:AddClickListener(arg_2_0._openBalanceUmbrellaView, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0._onOpenView, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.ReOpenWhileOpen, arg_2_0._onOpenView, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0._onCloseView, arg_2_0)
	arg_2_0:addEventCb(BalanceUmbrellaController.instance, BalanceUmbrellaEvent.ClueUpdate, arg_2_0.checkBtnShow, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, arg_2_0.setEpisodeListVisible, arg_2_0)
	arg_2_0:addEventCb(BalanceUmbrellaController.instance, BalanceUmbrellaEvent.ShowGetEffect, arg_2_0.showEffect, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnunfull:RemoveClickListener()
	arg_3_0._btnfull:RemoveClickListener()
end

function var_0_0._onOpenView(arg_4_0, arg_4_1)
	if arg_4_1 == ViewName.DungeonMapLevelView then
		arg_4_0:checkBtnShow()
	end
end

function var_0_0._onCloseView(arg_5_0, arg_5_1)
	if arg_5_1 == ViewName.DungeonMapLevelView then
		arg_5_0:checkBtnShow()
	end
end

function var_0_0._openBalanceUmbrellaView(arg_6_0)
	ViewMgr.instance:openView(ViewName.BalanceUmbrellaView)
end

function var_0_0.refreshView(arg_7_0)
	arg_7_0._isEpisodeListShow = true
	arg_7_0.chapterId = arg_7_0.viewParam.chapterId

	if arg_7_0.chapterId == DungeonEnum.ChapterId.Main1_7 then
		arg_7_0:checkBtnShow()

		local var_7_0 = BalanceUmbrellaModel.instance:getAllNewIds()

		for iter_7_0, iter_7_1 in pairs(var_7_0) do
			PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.BalanceUmbrellaClueView, {
				isGet = true,
				id = iter_7_1
			})
		end

		BalanceUmbrellaModel.instance:markAllNewIds()
	else
		gohelper.setActive(arg_7_0._btnfull, false)
		gohelper.setActive(arg_7_0._btnunfull, false)
	end

	gohelper.setActive(arg_7_0._effect1, false)
	gohelper.setActive(arg_7_0._effect2, false)
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:refreshView()
end

function var_0_0.onUpdateParam(arg_9_0)
	arg_9_0:refreshView()
end

function var_0_0.showEffect(arg_10_0)
	gohelper.setActive(arg_10_0._effect1, true)
	gohelper.setActive(arg_10_0._effect2, true)
	TaskDispatcher.runDelay(arg_10_0._delayHideEffect, arg_10_0, 1)
end

function var_0_0._delayHideEffect(arg_11_0)
	gohelper.setActive(arg_11_0._effect1, false)
	gohelper.setActive(arg_11_0._effect2, false)
end

function var_0_0.setEpisodeListVisible(arg_12_0, arg_12_1)
	arg_12_0._isEpisodeListShow = arg_12_1

	arg_12_0:checkBtnShow()
end

function var_0_0.checkBtnShow(arg_13_0)
	if arg_13_0.chapterId ~= DungeonEnum.ChapterId.Main1_7 then
		return
	end

	local var_13_0 = ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView)
	local var_13_1 = BalanceUmbrellaModel.instance:isGetAllClue()
	local var_13_2 = BalanceUmbrellaModel.instance:isHaveClue()

	gohelper.setActive(arg_13_0._btnfull, var_13_1 and not var_13_0 and arg_13_0._isEpisodeListShow)
	gohelper.setActive(arg_13_0._btnunfull, var_13_2 and not var_13_1 and not var_13_0 and arg_13_0._isEpisodeListShow)
end

function var_0_0.onClose(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._delayHideEffect, arg_14_0)
end

return var_0_0
