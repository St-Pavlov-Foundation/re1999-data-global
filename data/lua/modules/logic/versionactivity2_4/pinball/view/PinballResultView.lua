module("modules.logic.versionactivity2_4.pinball.view.PinballResultView", package.seeall)

local var_0_0 = class("PinballResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goFinish = gohelper.findChild(arg_1_0.viewGO, "#go_finish")
	arg_1_0._gonoFinish = gohelper.findChild(arg_1_0.viewGO, "#go_noFinish")
	arg_1_0._txttask = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_finish/#txt_taskdes")
	arg_1_0._txttask2 = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_noFinish/#txt_taskdes")
	arg_1_0._resexitem = gohelper.findChild(arg_1_0.viewGO, "#go_finish/items_ex/item")
	arg_1_0._resitem = gohelper.findChild(arg_1_0.viewGO, "items/item")
end

function var_0_0.onOpen(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio20)

	local var_2_0 = lua_activity178_episode.configDict[VersionActivity2_4Enum.ActivityId.Pinball][PinballModel.instance.leftEpisodeId]

	if not var_2_0 then
		return
	end

	arg_2_0:updateTask(var_2_0)

	local var_2_1 = PinballModel.instance.gameAddResDict
	local var_2_2 = {
		PinballEnum.ResType.Wood,
		PinballEnum.ResType.Mine,
		PinballEnum.ResType.Stone,
		PinballEnum.ResType.Food
	}
	local var_2_3 = {}
	local var_2_4 = {}

	for iter_2_0, iter_2_1 in ipairs(var_2_2) do
		local var_2_5 = PinballModel.instance:getResAdd(iter_2_1)

		var_2_3[iter_2_0] = {
			resType = iter_2_1,
			value = (var_2_1[iter_2_1] or 0) * (1 + var_2_5)
		}

		if arg_2_0._isFinish and arg_2_0._taskRewardDict[iter_2_1] then
			table.insert(var_2_4, {
				resType = iter_2_1,
				value = arg_2_0._taskRewardDict[iter_2_1]
			})
		end
	end

	gohelper.CreateObjList(arg_2_0, arg_2_0.createItem, var_2_3, nil, arg_2_0._resitem)

	if arg_2_0._isFinish then
		gohelper.CreateObjList(arg_2_0, arg_2_0.createItem, var_2_4, nil, arg_2_0._resexitem)
	end
end

function var_0_0.updateTask(arg_3_0, arg_3_1)
	local var_3_0 = string.splitToNumber(arg_3_1.target, "#")

	if not var_3_0 or #var_3_0 ~= 2 then
		logError("任务配置错误" .. arg_3_1.id)

		return
	end

	local var_3_1 = var_3_0[1]
	local var_3_2 = PinballModel.instance:getGameRes(var_3_1)
	local var_3_3 = var_3_0[2]

	arg_3_0._isFinish = var_3_3 <= var_3_2

	gohelper.setActive(arg_3_0._goFinish, arg_3_0._isFinish)
	gohelper.setActive(arg_3_0._gonoFinish, not arg_3_0._isFinish)

	local var_3_4 = ""

	if var_3_1 == 0 then
		var_3_4 = luaLang("pinball_any_res")
	else
		local var_3_5 = lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][var_3_1]

		if var_3_5 then
			var_3_4 = var_3_5.name
		end
	end

	arg_3_0._txttask.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("pinball_game_target2"), var_3_3, var_3_4)
	arg_3_0._txttask2.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("pinball_game_target2"), var_3_3, var_3_4)

	if not arg_3_0._isFinish then
		return
	end

	local var_3_6 = GameUtil.splitString2(arg_3_1.reward, true) or {}

	arg_3_0._taskRewardDict = {}

	for iter_3_0, iter_3_1 in pairs(var_3_6) do
		arg_3_0._taskRewardDict[iter_3_1[1]] = iter_3_1[2]
	end
end

function var_0_0.createItem(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = gohelper.findChildImage(arg_4_1, "#image_icon")

	gohelper.findChildTextMesh(arg_4_1, "#txt_num").text = Mathf.Round(arg_4_2.value)

	local var_4_1 = lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][arg_4_2.resType]

	if not var_4_1 then
		return
	end

	UISpriteSetMgr.instance:setAct178Sprite(var_4_0, var_4_1.icon)
end

function var_0_0.onClickModalMask(arg_5_0)
	ViewMgr.instance:closeView(ViewName.PinballGameView)
	arg_5_0:closeThis()
end

return var_0_0
