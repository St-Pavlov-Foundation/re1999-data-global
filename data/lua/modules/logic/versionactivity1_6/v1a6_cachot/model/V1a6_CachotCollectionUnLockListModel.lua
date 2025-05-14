module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotCollectionUnLockListModel", package.seeall)

local var_0_0 = class("V1a6_CachotCollectionUnLockListModel", ListScrollModel)

function var_0_0.release(arg_1_0)
	arg_1_0.unlockCollections = nil
end

function var_0_0.saveUnlockCollectionList(arg_2_0, arg_2_1)
	arg_2_0.unlockCollections = arg_2_0.unlockCollections or {}

	if arg_2_1 then
		for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
			local var_2_0 = {
				id = iter_2_1
			}

			table.insert(arg_2_0.unlockCollections, var_2_0)
		end
	end
end

function var_0_0.onInitData(arg_3_0)
	if not arg_3_0.unlockCollections then
		return
	end

	table.sort(arg_3_0.unlockCollections, arg_3_0.sortFunc)
	arg_3_0:setList(arg_3_0.unlockCollections)
end

function var_0_0.sortFunc(arg_4_0, arg_4_1)
	return arg_4_0.id < arg_4_1.id
end

function var_0_0.getNewUnlockCollectionsCount(arg_5_0)
	return arg_5_0.unlockCollections and #arg_5_0.unlockCollections or 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
