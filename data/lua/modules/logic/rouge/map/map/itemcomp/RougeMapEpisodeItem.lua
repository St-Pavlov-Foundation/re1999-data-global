module("modules.logic.rouge.map.map.itemcomp.RougeMapEpisodeItem", package.seeall)

local var_0_0 = class("RougeMapEpisodeItem", UserDataDispose)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:__onInit()

	arg_1_0.episodeMo = arg_1_1
	arg_1_0.map = arg_1_2
	arg_1_0.parentGo = arg_1_0.map.goLayerNodeContainer
	arg_1_0.index = arg_1_1.id

	arg_1_0:createGo()
	arg_1_0:createNodeItemList()
end

function var_0_0.createGo(arg_2_0)
	arg_2_0.go = gohelper.create3d(arg_2_0.parentGo, "episode" .. arg_2_0.index)
	arg_2_0.tr = arg_2_0.go:GetComponent(gohelper.Type_Transform)

	transformhelper.setLocalPos(arg_2_0.tr, RougeMapHelper.getEpisodePosX(arg_2_0.index), 0, 0)
end

function var_0_0.createNodeItemList(arg_3_0)
	arg_3_0.nodeItemList = {}

	local var_3_0 = arg_3_0.episodeMo:getNodeMoList()

	arg_3_0.posType = #var_3_0

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		local var_3_1 = RougeMapNodeItem.New()

		var_3_1:init(iter_3_1, arg_3_0.map, arg_3_0)
		table.insert(arg_3_0.nodeItemList, var_3_1)
	end
end

function var_0_0.getNodeItemList(arg_4_0)
	return arg_4_0.nodeItemList
end

function var_0_0.destroy(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.nodeItemList) do
		iter_5_1:destroy()
	end

	arg_5_0:__onDispose()
end

return var_0_0
