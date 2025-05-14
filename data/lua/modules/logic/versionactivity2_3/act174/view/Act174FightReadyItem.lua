module("modules.logic.versionactivity2_3.act174.view.Act174FightReadyItem", package.seeall)

local var_0_0 = class("Act174FightReadyItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._readyView = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._go = arg_2_1
	arg_2_0.transform = arg_2_1.transform
	arg_2_0._imageNum = gohelper.findChildImage(arg_2_1, "numbg/image_Num")

	CommonDragHelper.instance:registerDragObj(arg_2_1, arg_2_0.beginDrag, arg_2_0.onDrag, arg_2_0.endDrag, arg_2_0.checkDrag, arg_2_0, nil, true)
	arg_2_0:initBattleHero()
end

function var_0_0.addEventListeners(arg_3_0)
	return
end

function var_0_0.removeEventListeners(arg_4_0)
	return
end

function var_0_0.onDestroy(arg_5_0)
	CommonDragHelper.instance:unregisterDragObj(arg_5_0._go)
end

function var_0_0.initBattleHero(arg_6_0)
	arg_6_0.heroItemList = {}

	for iter_6_0 = 1, 4 do
		local var_6_0 = arg_6_0._readyView:getResInst(Activity174Enum.PrefabPath.BattleHero, arg_6_0._go)
		local var_6_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_6_0, Act174BattleHeroItem, arg_6_0)

		arg_6_0.heroItemList[iter_6_0] = var_6_1
	end
end

function var_0_0.setData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.teamInfo = arg_7_1
	arg_7_0.reverse = arg_7_2

	if arg_7_1 then
		arg_7_0.index = arg_7_1.index

		UISpriteSetMgr.instance:setAct174Sprite(arg_7_0._imageNum, "act174_ready_num_0" .. arg_7_0.index)
		arg_7_0:refreshTeam()
	end
end

function var_0_0.refreshTeam(arg_8_0)
	if arg_8_0.reverse then
		for iter_8_0 = 4, 1, -1 do
			local var_8_0 = math.abs(iter_8_0 - 5)
			local var_8_1 = Activity174Helper.MatchKeyInArray(arg_8_0.teamInfo.battleHeroInfo, iter_8_0, "index")

			arg_8_0.heroItemList[var_8_0]:setIndex(iter_8_0)
			arg_8_0.heroItemList[var_8_0]:setData(var_8_1, arg_8_0.teamInfo.index, true)
		end
	else
		for iter_8_1 = 1, 4 do
			local var_8_2 = Activity174Helper.MatchKeyInArray(arg_8_0.teamInfo.battleHeroInfo, iter_8_1, "index")

			arg_8_0.heroItemList[iter_8_1]:setIndex(iter_8_1)
			arg_8_0.heroItemList[iter_8_1]:setData(var_8_2, arg_8_0.teamInfo.index, false)
		end
	end
end

function var_0_0.beginDrag(arg_9_0)
	arg_9_0.isDraging = true
end

function var_0_0.onDrag(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:_tweenToPos(arg_10_0._go.transform, arg_10_2.position)
	gohelper.setAsLastSibling(arg_10_0._go)
end

function var_0_0.endDrag(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.isDraging = false

	local var_11_0 = arg_11_2.position
	local var_11_1 = arg_11_0:findTarget(var_11_0)

	if not var_11_1 then
		local var_11_2 = arg_11_0._readyView.frameTrList[arg_11_0.index]
		local var_11_3 = recthelper.rectToRelativeAnchorPos(var_11_2.position, arg_11_0.transform.parent)

		arg_11_0:setToPos(arg_11_0._go.transform, var_11_3, true, arg_11_0.tweenCallback, arg_11_0)
	else
		local var_11_4 = arg_11_0.transform.parent
		local var_11_5 = arg_11_0._readyView.frameTrList[var_11_1.index]
		local var_11_6 = recthelper.rectToRelativeAnchorPos(var_11_5.position, var_11_4)

		arg_11_0:setToPos(arg_11_0.transform, var_11_6, true, arg_11_0.tweenCallback, arg_11_0)

		if var_11_1 ~= arg_11_0 then
			local var_11_7 = var_11_1.transform.parent
			local var_11_8 = arg_11_0._readyView.frameTrList[arg_11_0.index]
			local var_11_9 = recthelper.rectToRelativeAnchorPos(var_11_8.position, var_11_7)
			local var_11_10 = var_11_1.index

			arg_11_0:setToPos(var_11_1.transform, var_11_9, true, function()
				arg_11_0._readyView:exchangeItem(arg_11_0.index, var_11_10)
			end, arg_11_0)
		end
	end

	AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_shenghuo_dqq_move)
end

function var_0_0.checkDrag(arg_13_0)
	if arg_13_0._readyView.unLockTeamCnt == 1 or arg_13_0.reverse or arg_13_0.isDraging or arg_13_0.tweenId then
		return true
	end
end

function var_0_0.findTarget(arg_14_0, arg_14_1)
	for iter_14_0 = 1, arg_14_0._readyView.unLockTeamCnt do
		local var_14_0 = arg_14_0._readyView.frameTrList[iter_14_0]
		local var_14_1, var_14_2 = recthelper.getAnchor(var_14_0)
		local var_14_3 = var_14_1 - 416
		local var_14_4 = var_14_2 + 276
		local var_14_5 = arg_14_0._readyView.readyItemList[iter_14_0]
		local var_14_6 = recthelper.screenPosToAnchorPos(arg_14_1, var_14_0.parent)

		if math.abs((var_14_6.x - var_14_3) * 2) < recthelper.getWidth(var_14_0) and math.abs((var_14_6.y - var_14_4) * 2) < recthelper.getHeight(var_14_0) then
			return var_14_5 or nil
		end
	end

	return nil
end

function var_0_0.setToPos(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	if arg_15_3 then
		CommonDragHelper.instance:setGlobalEnabled(false)

		arg_15_0.tweenId = ZProj.TweenHelper.DOAnchorPos(arg_15_1, arg_15_2.x, arg_15_2.y, 0.2, arg_15_4, arg_15_5)
	else
		recthelper.setAnchor(arg_15_1, arg_15_2.x, arg_15_2.y)

		if arg_15_4 then
			arg_15_4(arg_15_5)
		end
	end
end

function var_0_0.tweenCallback(arg_16_0)
	arg_16_0.tweenId = nil

	CommonDragHelper.instance:setGlobalEnabled(true)
end

function var_0_0._tweenToPos(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = recthelper.screenPosToAnchorPos(arg_17_2, arg_17_1.parent)
	local var_17_1, var_17_2 = recthelper.getAnchor(arg_17_1)

	if math.abs(var_17_1 - var_17_0.x) > 10 or math.abs(var_17_2 - var_17_0.y) > 10 then
		ZProj.TweenHelper.DOAnchorPos(arg_17_1, var_17_0.x, var_17_0.y, 0.2)
	else
		recthelper.setAnchor(arg_17_1, var_17_0.x, var_17_0.y)
	end
end

return var_0_0
