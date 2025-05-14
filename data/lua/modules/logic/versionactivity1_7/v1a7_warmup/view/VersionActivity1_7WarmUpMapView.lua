module("modules.logic.versionactivity1_7.v1a7_warmup.view.VersionActivity1_7WarmUpMapView", package.seeall)

local var_0_0 = class("VersionActivity1_7WarmUpMapView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gomap = gohelper.findChild(arg_1_0.viewGO, "#go_map")
	arg_1_0._gomapcontent = gohelper.findChild(arg_1_0.viewGO, "#go_map/Viewport/Content")

	local var_1_0 = arg_1_0.viewContainer:getSetting().otherRes.mapRes

	arg_1_0._gomaproot = arg_1_0.viewContainer:getResInst(var_1_0, arg_1_0._gomapcontent, "mapRoot")
	arg_1_0.lineAnimator = gohelper.findChildComponent(arg_1_0._gomaproot, "Line", typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(Activity125Controller.instance, Activity125Event.DataUpdate, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(Activity125Controller.instance, Activity125Event.EpisodeUnlock, arg_2_0.unlockLine, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(Activity125Controller.instance, Activity125Event.DataUpdate, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(Activity125Controller.instance, Activity125Event.EpisodeUnlock, arg_3_0.unlockLine, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0._actId = ActivityEnum.Activity.Activity1_7WarmUp

	if Activity125Model.instance:getById(arg_5_0._actId) then
		arg_5_0:refreshUI()
	end
end

function var_0_0.refreshUI(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0.unlockLineCallback, arg_6_0)
	arg_6_0:initItemList()
	arg_6_0:updateEpisodes()
	arg_6_0:updateMapPos(arg_6_0.notFirst)
end

function var_0_0.unlockLine(arg_7_0, arg_7_1)
	local var_7_0 = Activity125Model.instance:getLastEpisode(arg_7_0._actId)
	local var_7_1 = Activity125Model.instance:checkLocalIsPlay(arg_7_0._actId, var_7_0)

	if var_7_0 == 1 and not var_7_1 then
		gohelper.setActive(arg_7_0.lineAnimator, false)

		return
	end

	gohelper.setActive(arg_7_0.lineAnimator, true)

	if arg_7_1 then
		arg_7_0.lineAnimator:Play(string.format("go%s", var_7_0 - 1), 0, 1)
	else
		arg_7_0.unlockEpisode = var_7_0

		arg_7_0.lineAnimator:Play(string.format("go%s", var_7_0 - 1))
		TaskDispatcher.runDelay(arg_7_0.unlockLineCallback, arg_7_0, 0.84)
	end
end

function var_0_0.unlockLineCallback(arg_8_0)
	local var_8_0 = arg_8_0.unlockEpisode

	arg_8_0.unlockEpisode = nil

	local var_8_1 = arg_8_0.itemList[var_8_0]

	if var_8_1 then
		var_8_1:refreshItem()
	end
end

function var_0_0.updateMapPos(arg_9_0, arg_9_1)
	if arg_9_0._movetweenId then
		ZProj.TweenHelper.KillById(arg_9_0._movetweenId)

		arg_9_0._movetweenId = nil
	end

	local var_9_0 = math.max(recthelper.getWidth(arg_9_0._gomapcontent.transform) - recthelper.getWidth(arg_9_0._gomap.transform), 0)
	local var_9_1 = Activity125Model.instance:getSelectEpisodeId(arg_9_0._actId)

	if arg_9_0.selectId == var_9_1 then
		return
	end

	arg_9_0.selectId = var_9_1

	local var_9_2 = arg_9_0:getItemPos(var_9_1)
	local var_9_3 = -math.min(var_9_2, var_9_0)

	if arg_9_1 then
		local var_9_4 = recthelper.getAnchorX(arg_9_0._gomapcontent.transform)
		local var_9_5 = math.abs(var_9_3 - var_9_4)

		if var_9_5 > 1 then
			local var_9_6 = var_9_5 / 1000

			arg_9_0._movetweenId = ZProj.TweenHelper.DOAnchorPosX(arg_9_0._gomapcontent.transform, var_9_3, var_9_6)
		end
	else
		recthelper.setAnchorX(arg_9_0._gomapcontent.transform, var_9_3)
	end

	arg_9_0.notFirst = true
end

function var_0_0.getItemPos(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.itemList[arg_10_1]

	if not var_10_0 then
		return 0
	end

	local var_10_1 = recthelper.getWidth(arg_10_0._gomapcontent.transform)
	local var_10_2 = recthelper.getWidth(arg_10_0._gomap.transform) * 0.5
	local var_10_3 = var_10_1 * 0.5
	local var_10_4 = var_10_2 - 200
	local var_10_5 = var_10_3 + var_10_0:getPos() - var_10_4

	return math.max(var_10_5, 0)
end

function var_0_0.initItemList(arg_11_0)
	if arg_11_0.itemList then
		return
	end

	local var_11_0 = Activity125Model.instance:getEpisodeCount(arg_11_0._actId)

	arg_11_0.itemList = arg_11_0:getUserDataTb_()

	for iter_11_0 = 1, var_11_0 do
		local var_11_1 = gohelper.findChild(arg_11_0._gomaproot, string.format("mapitem%s", iter_11_0))

		arg_11_0.itemList[iter_11_0] = arg_11_0:createEpisodeItem(var_11_1)
	end
end

function var_0_0.createEpisodeItem(arg_12_0, arg_12_1)
	local var_12_0 = VersionActivity1_7WarmUpEpisodeItem.New()

	var_12_0.viewContainer = arg_12_0.viewContainer

	var_12_0:onInit(arg_12_1)

	return var_12_0
end

function var_0_0.updateEpisodes(arg_13_0)
	local var_13_0 = Activity125Model.instance:getEpisodeList(arg_13_0._actId)

	if var_13_0 then
		for iter_13_0, iter_13_1 in ipairs(var_13_0) do
			local var_13_1 = arg_13_0.itemList[iter_13_0]

			if var_13_1 then
				var_13_1:updateData(iter_13_1)
			end
		end
	end

	if not arg_13_0.unlockEpisode then
		arg_13_0:unlockLine(true)
	end
end

function var_0_0.onClose(arg_14_0)
	return
end

function var_0_0.onDestroyView(arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0.unlockLineCallback, arg_15_0)

	if arg_15_0.itemList then
		for iter_15_0, iter_15_1 in ipairs(arg_15_0.itemList) do
			iter_15_1:onDestroy()
		end
	end

	if arg_15_0._movetweenId then
		ZProj.TweenHelper.KillById(arg_15_0._movetweenId)

		arg_15_0._movetweenId = nil
	end
end

return var_0_0
