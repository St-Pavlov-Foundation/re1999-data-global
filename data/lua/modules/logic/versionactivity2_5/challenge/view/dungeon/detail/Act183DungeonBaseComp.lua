module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonBaseComp", package.seeall)

local var_0_0 = class("Act183DungeonBaseComp", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
	arg_1_0.tran = arg_1_1.transform
end

function var_0_0.checkIsVisible(arg_2_0)
	return true
end

function var_0_0.onUpdateMO(arg_3_0, arg_3_1)
	arg_3_0:updateInfo(arg_3_1)
	arg_3_0:refresh()
end

function var_0_0.updateInfo(arg_4_0, arg_4_1)
	arg_4_0._episodeMo = arg_4_1
	arg_4_0._status = arg_4_0._episodeMo:getStatus()
	arg_4_0._episodeCo = arg_4_0._episodeMo:getConfig()
	arg_4_0._episodeId = arg_4_0._episodeMo:getEpisodeId()
	arg_4_0._episodeType = arg_4_0._episodeMo:getEpisodeType()
	arg_4_0._passOrder = arg_4_0._episodeMo:getPassOrder()
	arg_4_0._groupId = arg_4_0._episodeCo.groupId
	arg_4_0._activityId = arg_4_0._episodeCo.activityId
	arg_4_0._groupEpisodeMo = Act183Model.instance:getGroupEpisodeMo(arg_4_0._groupId)
	arg_4_0._groupType = arg_4_0._groupEpisodeMo:getGroupType()
end

function var_0_0.refresh(arg_5_0)
	arg_5_0._isVisible = arg_5_0:checkIsVisible()

	gohelper.setActive(arg_5_0.go, arg_5_0._isVisible)

	if not arg_5_0._isVisible then
		return
	end

	arg_5_0:show()
end

function var_0_0.show(arg_6_0)
	return
end

function var_0_0.createObjList(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6)
	if not arg_7_1 or not arg_7_2 or not arg_7_3 or not arg_7_4 or not arg_7_5 or not arg_7_6 then
		logError("缺失参数")

		return
	end

	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		local var_7_1 = arg_7_0:_getOrCreateItem(iter_7_0, arg_7_2, arg_7_3, arg_7_4)

		gohelper.setActive(var_7_1.go, true)
		arg_7_5(arg_7_0, var_7_1, iter_7_1, iter_7_0)

		var_7_0[var_7_1] = true
	end

	for iter_7_2, iter_7_3 in pairs(arg_7_2) do
		if not var_7_0[iter_7_3] then
			arg_7_6(arg_7_0, iter_7_3)
		end
	end

	gohelper.setActive(arg_7_3, false)
end

function var_0_0.createObjListNum(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6)
	if not arg_8_1 or not arg_8_2 or not arg_8_3 or not arg_8_4 or not arg_8_5 or not arg_8_6 then
		logError("缺失参数")

		return
	end

	local var_8_0 = {}

	for iter_8_0 = 1, arg_8_1 do
		local var_8_1 = arg_8_0:_getOrCreateItem(iter_8_0, arg_8_2, arg_8_3, arg_8_4)

		arg_8_5(arg_8_0, var_8_1, nil, iter_8_0)
		gohelper.setActive(var_8_1.go, true)

		var_8_0[var_8_1] = true
	end

	for iter_8_1, iter_8_2 in pairs(arg_8_2) do
		if not var_8_0[iter_8_2] then
			arg_8_6(arg_8_0, iter_8_2)
		end
	end

	gohelper.setActive(arg_8_3, false)
end

function var_0_0._getOrCreateItem(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = arg_9_2[arg_9_1]

	if not var_9_0 then
		var_9_0 = arg_9_0:getUserDataTb_()
		var_9_0.go = gohelper.cloneInPlace(arg_9_3, "item_" .. arg_9_1)
		var_9_0.index = arg_9_1

		arg_9_4(arg_9_0, var_9_0, arg_9_1)

		arg_9_2[arg_9_1] = var_9_0
	end

	return var_9_0
end

function var_0_0._defaultItemFreeFunc(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_1.go, false)
end

function var_0_0.getHeight(arg_11_0)
	if not arg_11_0.tran then
		logError(string.format("Transform组件不存在 cls = %s", arg_11_0.__cname))

		return 0
	end

	if not arg_11_0._isVisible then
		return 0
	end

	ZProj.UGUIHelper.RebuildLayout(arg_11_0.tran)

	return recthelper.getHeight(arg_11_0.tran)
end

function var_0_0.focus(arg_12_0, arg_12_1)
	return 0
end

function var_0_0.onDestroy(arg_13_0)
	arg_13_0:__onDispose()
end

return var_0_0
