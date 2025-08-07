module("modules.logic.sp01.assassin2.controller.AssassinStealthGameEffectMgr", package.seeall)

local var_0_0 = class("AssassinStealthGameEffectMgr")

function var_0_0.init(arg_1_0)
	arg_1_0.path2AssetItemDic = {}
	arg_1_0.resList = {}
	arg_1_0.pathList = {}
	arg_1_0.path2PointListDic = {}
end

function var_0_0.getEffectRes(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = AssassinStealthGameHelper.getEffectUrl(arg_2_1)
	local var_2_1 = arg_2_0.path2AssetItemDic[var_2_0]

	if var_2_1 then
		local var_2_2 = gohelper.clone(var_2_1:GetResource(var_2_0))

		gohelper.addChild(arg_2_2, var_2_2)
	else
		if not arg_2_0.path2PointListDic[var_2_0] then
			arg_2_0.path2PointListDic[var_2_0] = {}
		end

		table.insert(arg_2_0.path2PointListDic[var_2_0], arg_2_2)
		table.insert(arg_2_0.pathList, var_2_0)
		loadAbAsset(var_2_0, false, arg_2_0.onLoadCallback, arg_2_0)
	end
end

function var_0_0.onLoadCallback(arg_3_0, arg_3_1)
	if not arg_3_0.resList then
		return
	end

	table.insert(arg_3_0.resList, arg_3_1)

	local var_3_0 = arg_3_1.ResPath

	if arg_3_1.IsLoadSuccess then
		arg_3_1:Retain()

		arg_3_0.path2AssetItemDic[var_3_0] = arg_3_1

		local var_3_1 = arg_3_0.path2PointListDic[var_3_0]

		if var_3_1 then
			local var_3_2 = arg_3_1:GetResource(var_3_0)

			for iter_3_0, iter_3_1 in ipairs(var_3_1) do
				if not gohelper.isNil(iter_3_1) then
					local var_3_3 = gohelper.clone(var_3_2)

					gohelper.addChild(iter_3_1, var_3_3)
				end
			end

			tabletool.clear(arg_3_0.path2PointListDic[var_3_0])
		end
	else
		logError(string.format("AssassinStealthGameEffectMgr:onLoadCallback error, load effect failed, path:%s", var_3_0))
	end
end

function var_0_0.dispose(arg_4_0)
	if arg_4_0.pathList and #arg_4_0.resList < #arg_4_0.pathList then
		for iter_4_0, iter_4_1 in ipairs(arg_4_0.pathList) do
			removeAssetLoadCb(iter_4_1, arg_4_0.onLoadCallback, arg_4_0)
		end
	end

	if arg_4_0.resList then
		for iter_4_2, iter_4_3 in ipairs(arg_4_0.resList) do
			iter_4_3:Release()
			rawset(arg_4_0.resList, iter_4_2, nil)
		end
	end

	arg_4_0.pathList = nil
	arg_4_0.resList = nil
	arg_4_0.path2AssetItemDic = nil
	arg_4_0.path2PointListDic = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
