module("modules.logic.versionactivity1_4.dungeon.view.VersionActivity1_4DungeonItem", package.seeall)

local var_0_0 = class("VersionActivity1_4DungeonItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._imagepoint = gohelper.findChildImage(arg_1_0.viewGO, "#image_point")
	arg_1_0._imageline = gohelper.findChildImage(arg_1_0.viewGO, "#image_line")
	arg_1_0._goUnlock = gohelper.findChild(arg_1_0.viewGO, "unlock")
	arg_1_0._imagestagefinish = gohelper.findChildImage(arg_1_0.viewGO, "unlock/#go_stagefinish")
	arg_1_0._txtstagename = gohelper.findChildText(arg_1_0.viewGO, "unlock/info/#txt_stagename")
	arg_1_0._txtstagenum = gohelper.findChildText(arg_1_0.viewGO, "unlock/info/#txt_stageNum")
	arg_1_0._stars = {}

	for iter_1_0 = 1, 1 do
		local var_1_0 = arg_1_0:getUserDataTb_()

		var_1_0.index = iter_1_0
		var_1_0.go = gohelper.findChild(arg_1_0.viewGO, "unlock/info/#go_star" .. iter_1_0)
		var_1_0.has = gohelper.findChild(var_1_0.go, "has")
		var_1_0.no = gohelper.findChild(var_1_0.go, "no")

		table.insert(arg_1_0._stars, var_1_0)
	end

	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "unlock/#btn_click")
	arg_1_0._animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	if not arg_4_0._config then
		return
	end

	if DungeonModel.instance:isCanChallenge(arg_4_0._config) then
		VersionActivity1_4DungeonModel.instance:setSelectEpisodeId(arg_4_0._config.id)
		ViewMgr.instance:openView(ViewName.VersionActivity1_4DungeonEpisodeView, {
			episodeId = arg_4_0._config.id
		})
	else
		GameFacade.showToast(ToastEnum.V1a4_act130EpisodeNotUnlock)
	end
end

function var_0_0.refreshItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._config = arg_5_1

	if not arg_5_1 then
		gohelper.setActive(arg_5_0.viewGO, false)

		return
	end

	TaskDispatcher.cancelTask(arg_5_0.playAnim, arg_5_0)
	gohelper.setActive(arg_5_0.viewGO, true)

	local var_5_0 = DungeonModel.instance:isCanChallenge(arg_5_1)

	gohelper.setActive(arg_5_0._goUnlock, var_5_0)
	UISpriteSetMgr.instance:setV1a4Role37Sprite(arg_5_0._imagepoint, var_5_0 and "v1a4_dungeon_stagebase2" or "v1a4_dungeon_stagebase1")
	UISpriteSetMgr.instance:setV1a4Role37Sprite(arg_5_0._imageline, "v1a4_dungeon_stagebaseline2")
	gohelper.setActive(arg_5_0._imageline, var_5_0)

	local var_5_1 = false

	if var_5_0 then
		arg_5_0._txtstagename.text = arg_5_1.name
		arg_5_0._txtstagenum.text = GameUtil.fillZeroInLeft(arg_5_2, 2)

		local var_5_2 = DungeonModel.instance:getEpisodeInfo(arg_5_1.id)
		local var_5_3 = var_5_2 and var_5_2.star or 0

		for iter_5_0, iter_5_1 in pairs(arg_5_0._stars) do
			gohelper.setActive(iter_5_1.has, var_5_3 >= iter_5_1.index)
			gohelper.setActive(iter_5_1.no, var_5_3 < iter_5_1.index)
		end

		local var_5_4 = DungeonModel.instance:hasPassLevel(arg_5_1.id)
		local var_5_5 = "v1a4_dungeon_stagebg1"
		local var_5_6 = arg_5_2 == 5 and (var_5_4 and "v1a4_dungeon_stagebg3" or "v1a4_dungeon_stagebg4") or var_5_4 and "v1a4_dungeon_stagebg1" or "v1a4_dungeon_stagebg2"

		UISpriteSetMgr.instance:setV1a4Role37Sprite(arg_5_0._imagestagefinish, var_5_6)

		local var_5_7 = VersionActivity1_4DungeonModel.instance:getEpisodeState(arg_5_1.id)

		if var_5_4 then
			if var_5_7 < 2 then
				arg_5_0.animName = "finish"

				arg_5_0:playAnim()
			else
				arg_5_0.animName = "open"

				arg_5_0:playAnim()
			end
		elseif var_5_7 < 1 then
			gohelper.setActive(arg_5_0.viewGO, false)

			arg_5_0.animName = "unlock"

			TaskDispatcher.runDelay(arg_5_0.playAnim, arg_5_0, 1.67)

			var_5_1 = true
		else
			arg_5_0.animName = "open"

			arg_5_0:playAnim()
		end
	end

	return var_5_1, var_5_0
end

function var_0_0.playAnim(arg_6_0)
	gohelper.setActive(arg_6_0.viewGO, true)
	arg_6_0._animator:Play(arg_6_0.animName)

	if arg_6_0.animName == "unlock" then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_deblockingmap)
		VersionActivity1_4DungeonModel.instance:setEpisodeState(arg_6_0._config.id, 1)
	elseif arg_6_0.animName == "finish" then
		VersionActivity1_4DungeonModel.instance:setEpisodeState(arg_6_0._config.id, 2)
	end
end

function var_0_0.onDestroy(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.playAnim, arg_7_0)
	arg_7_0:removeEventListeners()
	arg_7_0:__onDispose()
end

return var_0_0
