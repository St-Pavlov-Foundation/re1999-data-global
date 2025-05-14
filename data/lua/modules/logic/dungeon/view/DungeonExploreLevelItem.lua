module("modules.logic.dungeon.view.DungeonExploreLevelItem", package.seeall)

local var_0_0 = class("DungeonExploreLevelItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._goselected = gohelper.findChild(arg_1_1, "#go_selected")
	arg_1_0._btnclick = gohelper.findChildButton(arg_1_1, "#btn_click")
	arg_1_0._txtindex = gohelper.findChildText(arg_1_1, "#txt_index")
	arg_1_0._goline = gohelper.findChild(arg_1_1, "line")
	arg_1_0._goexploring = gohelper.findChild(arg_1_1, "#go_exploring")
	arg_1_0._golock = gohelper.findChild(arg_1_1, "#go_lock")

	arg_1_0._btnclick:AddClickListener(arg_1_0._click, arg_1_0)

	arg_1_0._anim = arg_1_1:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._progressItems = {}

	for iter_1_0 = 1, 3 do
		arg_1_0._progressItems[iter_1_0] = {}
		arg_1_0._progressItems[iter_1_0].dark = gohelper.findChild(arg_1_1, "progress/#go_progressitem" .. iter_1_0 .. "/dark")
		arg_1_0._progressItems[iter_1_0].light = gohelper.findChild(arg_1_1, "progress/#go_progressitem" .. iter_1_0 .. "/light")
		arg_1_0._progressItems[iter_1_0].unlockEffect = gohelper.findChild(arg_1_1, "progress/#go_progressitem" .. iter_1_0 .. "/click_light")
	end

	ExploreController.instance:registerCallback(ExploreEvent.OnLevelClick, arg_1_0.onLevelClick, arg_1_0)
end

function var_0_0.setData(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0._index = arg_2_2
	arg_2_0._config = arg_2_1
	arg_2_0._txtindex.text = arg_2_2

	gohelper.setActive(arg_2_0._goline, not arg_2_3)

	arg_2_0._lock = false

	local var_2_0 = lua_explore_scene.configDict[arg_2_1.chapterId][arg_2_1.id]

	if not var_2_0 then
		logError("缺失密室地图配置" .. arg_2_1.chapterId .. " + " .. arg_2_1.id)

		return
	end

	gohelper.setActive(arg_2_0._goexploring, var_2_0.id == ExploreSimpleModel.instance.nowMapId)
	gohelper.setActive(arg_2_0._golock, not ExploreSimpleModel.instance:getMapIsUnLock(var_2_0.id))

	if not ExploreSimpleModel.instance:getMapIsUnLock(var_2_0.id) then
		arg_2_0._txtindex.text = ""
		arg_2_0._lock = true
	end

	local var_2_1 = true

	if not arg_2_0._lock then
		var_2_1 = ExploreSimpleModel.instance:getEpisodeIsShowUnlock(arg_2_1.chapterId, arg_2_1.id)
	end

	local var_2_2, var_2_3, var_2_4, var_2_5, var_2_6, var_2_7 = ExploreSimpleModel.instance:getCoinCountByMapId(var_2_0.id)
	local var_2_8 = var_2_4 == var_2_7
	local var_2_9 = var_2_3 == var_2_6
	local var_2_10 = var_2_2 == var_2_5

	gohelper.setActive(arg_2_0._progressItems[1].dark, not var_2_8)
	gohelper.setActive(arg_2_0._progressItems[1].light, var_2_8)
	gohelper.setActive(arg_2_0._progressItems[2].dark, not var_2_9)
	gohelper.setActive(arg_2_0._progressItems[2].light, var_2_9)
	gohelper.setActive(arg_2_0._progressItems[3].dark, not var_2_10)
	gohelper.setActive(arg_2_0._progressItems[3].light, var_2_10)

	if not var_2_1 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_doom_disappear)
		arg_2_0._anim:Play("unlock", 0, 0)
		ExploreSimpleModel.instance:markEpisodeShowUnlock(arg_2_1.chapterId, arg_2_1.id)
	else
		arg_2_0._anim:Play("idle", 0, 0)
	end

	arg_2_0:_hideUnlockEffect()

	local var_2_11 = false

	if var_2_10 and not ExploreSimpleModel.instance:getCollectFullIsShow(arg_2_1.chapterId, ExploreEnum.CoinType.Bonus, arg_2_1.id) then
		ExploreSimpleModel.instance:markCollectFullIsShow(arg_2_1.chapterId, ExploreEnum.CoinType.Bonus, arg_2_1.id)
		gohelper.setActive(arg_2_0._progressItems[3].unlockEffect, true)

		var_2_11 = true
	end

	if var_2_9 and not ExploreSimpleModel.instance:getCollectFullIsShow(arg_2_1.chapterId, ExploreEnum.CoinType.GoldCoin, arg_2_1.id) then
		ExploreSimpleModel.instance:markCollectFullIsShow(arg_2_1.chapterId, ExploreEnum.CoinType.GoldCoin, arg_2_1.id)
		gohelper.setActive(arg_2_0._progressItems[2].unlockEffect, true)

		var_2_11 = true
	end

	if var_2_8 and not ExploreSimpleModel.instance:getCollectFullIsShow(arg_2_1.chapterId, ExploreEnum.CoinType.PurpleCoin, arg_2_1.id) then
		ExploreSimpleModel.instance:markCollectFullIsShow(arg_2_1.chapterId, ExploreEnum.CoinType.PurpleCoin, arg_2_1.id)
		gohelper.setActive(arg_2_0._progressItems[1].unlockEffect, true)

		var_2_11 = true
	end

	TaskDispatcher.cancelTask(arg_2_0._hideUnlockEffect, arg_2_0)

	if var_2_11 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_doom_disappear)
		TaskDispatcher.runDelay(arg_2_0._hideUnlockEffect, arg_2_0, 1.5)
	end
end

function var_0_0._hideUnlockEffect(arg_3_0)
	for iter_3_0 = 1, 3 do
		gohelper.setActive(arg_3_0._progressItems[iter_3_0].unlockEffect, false)
	end
end

function var_0_0._click(arg_4_0)
	if arg_4_0._lock then
		ToastController.instance:showToast(ExploreConstValue.Toast.ExploreLock)

		return
	end

	ExploreController.instance:dispatchEvent(ExploreEvent.OnLevelClick, arg_4_0._index)
end

function var_0_0.onLevelClick(arg_5_0, arg_5_1)
	gohelper.setActive(arg_5_0._goselected, arg_5_1 == arg_5_0._index)
end

function var_0_0.destroy(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._hideUnlockEffect, arg_6_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnLevelClick, arg_6_0.onLevelClick, arg_6_0)
	arg_6_0._btnclick:RemoveClickListener()

	arg_6_0._index = 0
	arg_6_0._config = nil
	arg_6_0._goselected = nil
	arg_6_0._btnclick = nil
	arg_6_0._txtindex = nil
	arg_6_0._goline = nil
	arg_6_0._goexploring = nil
	arg_6_0._golock = nil

	for iter_6_0 in pairs(arg_6_0._progressItems) do
		for iter_6_1 in pairs(arg_6_0._progressItems[iter_6_0]) do
			arg_6_0._progressItems[iter_6_0][iter_6_1] = nil
		end

		arg_6_0._progressItems[iter_6_0] = nil
	end
end

return var_0_0
