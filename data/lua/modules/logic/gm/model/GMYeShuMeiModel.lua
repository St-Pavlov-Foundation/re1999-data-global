module("modules.logic.gm.model.GMYeShuMeiModel", package.seeall)

local var_0_0 = class("GMYeShuMeiModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clearData()
end

function var_0_0.getAllLevelData(arg_3_0)
	arg_3_0._allLevelData = YeShuMeiConfig.instance:getYeShuMeiLevelData()
end

function var_0_0.setCurLevelId(arg_4_0, arg_4_1)
	arg_4_0:getAllLevelData()

	arg_4_0._copyData = tabletool.copy(arg_4_0._allLevelData)

	local var_4_0

	for iter_4_0, iter_4_1 in pairs(arg_4_0._copyData) do
		if iter_4_0 == arg_4_1 then
			var_4_0 = iter_4_1

			break
		end
	end

	if var_4_0 == nil then
		arg_4_0._curLevelData = YeShuMeiLevelMo.New(arg_4_1)
		arg_4_0._copyData[arg_4_1] = arg_4_0._curLevelData
	else
		arg_4_0._curLevelData = var_4_0
	end

	return arg_4_0._curLevelData
end

function var_0_0.getCurLevelData(arg_5_0)
	return arg_5_0._curLevelData
end

function var_0_0.addPoint(arg_6_0)
	if arg_6_0._curLevelData == nil then
		return
	end

	local var_6_0 = 0

	if arg_6_0._curLevelData.points == nil then
		arg_6_0._curLevelData.points = {}
	else
		for iter_6_0 = 1, #arg_6_0._curLevelData.points do
			local var_6_1 = arg_6_0._curLevelData.points[iter_6_0]

			if var_6_0 < var_6_1.id then
				var_6_0 = var_6_1.id
			end
		end

		var_6_0 = var_6_0 + 1
	end

	local var_6_2 = {}

	if var_6_0 == 1 then
		var_6_2 = GMYeShuMeiPointMo.New(3, var_6_0)
	else
		var_6_2 = GMYeShuMeiPointMo.New(1, var_6_0)
	end

	table.insert(arg_6_0._curLevelData.points, var_6_2)

	return var_6_2
end

function var_0_0.deletePoint(arg_7_0, arg_7_1)
	if arg_7_0._curLevelData == nil then
		return
	end

	if arg_7_0._curLevelData.points == nil then
		return
	end

	for iter_7_0 = 1, #arg_7_0._curLevelData.points do
		if arg_7_0._curLevelData.points[iter_7_0].id == arg_7_1 then
			table.remove(arg_7_0._curLevelData.points, iter_7_0)

			break
		end
	end
end

function var_0_0.addLines(arg_8_0)
	local var_8_0 = 0

	if arg_8_0._curLevelData.lines == nil then
		arg_8_0._curLevelData.lines = {}
	else
		for iter_8_0 = 1, #arg_8_0._curLevelData.lines do
			local var_8_1 = arg_8_0._curLevelData.lines[iter_8_0]

			if var_8_0 < var_8_1.id then
				var_8_0 = var_8_1.id
			end
		end

		var_8_0 = var_8_0 + 1
	end

	local var_8_2 = YeShuMeiLineMo.New(var_8_0)

	table.insert(arg_8_0._curLevelData.lines, var_8_2)

	return var_8_2
end

function var_0_0.deleteLines(arg_9_0, arg_9_1)
	if arg_9_0._curLevelData == nil then
		return
	end

	if arg_9_0._curLevelData.lines == nil then
		return
	end

	for iter_9_0 = 1, #arg_9_0._curLevelData.lines do
		if arg_9_0._curLevelData.lines[iter_9_0].id == arg_9_1 then
			table.remove(arg_9_0._curLevelData.lines, iter_9_0)

			break
		end
	end
end

function var_0_0.checkLineExist(arg_10_0, arg_10_1, arg_10_2)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0._curLevelData.lines) do
		if iter_10_1:havePoint(arg_10_1, arg_10_2) then
			return true
		end
	end

	return false
end

function var_0_0.addOrders(arg_11_0, arg_11_1)
	if arg_11_0._curLevelData == nil then
		return
	end

	if arg_11_0._curLevelData.orders == nil then
		arg_11_0._curLevelData.orders = {}
	end

	if not tabletool.indexOf(arg_11_0._curLevelData.orders, arg_11_1) then
		table.insert(arg_11_0._curLevelData.orders, arg_11_1)

		return true
	end

	return false
end

function var_0_0.deleteOrders(arg_12_0, arg_12_1)
	if arg_12_0._curLevelData == nil then
		return
	end

	if arg_12_0._curLevelData.orders == nil then
		return
	end

	for iter_12_0, iter_12_1 in ipairs(arg_12_0._curLevelData.orders) do
		if iter_12_1 == arg_12_1 then
			table.remove(arg_12_0._curLevelData.orders, iter_12_0)

			break
		end
	end
end

function var_0_0.setCurLevelOrder(arg_13_0, arg_13_1)
	if arg_13_0._curLevelData == nil then
		return
	end

	if arg_13_0._curLevelData.orders == nil then
		return
	end

	arg_13_0._curLevelOrder = arg_13_1
end

function var_0_0.getCurLevelOrder(arg_14_0)
	return arg_14_0._curLevelOrder
end

function var_0_0.saveAndExport(arg_15_0)
	if arg_15_0._copyData == nil then
		return
	end

	for iter_15_0, iter_15_1 in pairs(arg_15_0._copyData) do
		local var_15_0 = {}

		if iter_15_1.lines ~= nil then
			local var_15_1 = {}

			for iter_15_2 = 1, #iter_15_1.lines do
				local var_15_2 = iter_15_1.lines[iter_15_2]
				local var_15_3 = var_15_2._beginPointId .. "_" .. var_15_2._endPointId
				local var_15_4 = var_15_2._endPointId .. "_" .. var_15_2._beginPointId

				if var_15_1[var_15_3] == nil or var_15_1[var_15_4] == nil then
					var_15_1[var_15_3] = var_15_2
					var_15_1[var_15_4] = var_15_2
				else
					local var_15_5 = {}

					if var_15_0[var_15_3] == nil then
						var_15_0[var_15_3] = {}
					end

					table.insert(var_15_0[var_15_3], var_15_2.id)
				end
			end
		end

		for iter_15_3, iter_15_4 in pairs(var_15_0) do
			if #iter_15_4 > 0 then
				for iter_15_5 = 1, #iter_15_4 do
					local var_15_6 = iter_15_4[iter_15_5]

					if iter_15_1.lines == nil then
						break
					end

					for iter_15_6 = 1, #iter_15_1.lines do
						if iter_15_1.lines[iter_15_6].id == var_15_6 then
							table.remove(iter_15_1.lines, iter_15_6)

							break
						end
					end
				end
			end
		end

		if iter_15_1.lines ~= nil then
			for iter_15_7 = #iter_15_1.lines, -1 do
				local var_15_7 = iter_15_1.lines[iter_15_7]
				local var_15_8 = var_15_7._beginPointId
				local var_15_9 = var_15_7._endPointId
				local var_15_10 = false
				local var_15_11 = false

				for iter_15_8 = 1, #iter_15_1.points do
					local var_15_12 = iter_15_1.points[iter_15_8]

					if var_15_8 and var_15_12.id == var_15_8 then
						var_15_10 = true
					end

					if var_15_9 and var_15_12.id == var_15_9 then
						var_15_11 = true
					end
				end

				if var_15_8 == nil or var_15_9 == nil or not var_15_11 or not var_15_10 then
					table.remove(iter_15_1.lines, iter_15_7)
				end
			end
		end

		if iter_15_1.orders ~= nil then
			for iter_15_9, iter_15_10 in ipairs(iter_15_1.orders) do
				if string.nilorempty(iter_15_10) then
					table.remove(iter_15_1.orders, iter_15_9)
				end
			end
		end
	end

	local var_15_13 = ""
	local var_15_14 = "return { \n"

	for iter_15_11, iter_15_12 in pairs(arg_15_0._copyData) do
		var_15_14 = var_15_14 .. "{" .. iter_15_12:getStr() .. "},\n"
	end

	local var_15_15 = var_15_14 .. "}\n"
	local var_15_16 = "Assets/ZProj/Scripts/Lua/modules/configs/yeshumei/" .. YeShuMeiConfig.instance._ActivityDataName .. ".lua"

	logNormal("GMYeShuMeiModel:saveAndExport:", var_15_15)
	logNormal("GMYeShuMeiModel:saveAndExport Path: ", var_15_16)
	logError("保存成功~")

	local var_15_17 = SLFramework.FileHelper

	var_15_17.EnsureDirForFile(var_15_16)
	var_15_17.WriteTextToPath(var_15_16, var_15_15)
end

function var_0_0.clearData(arg_16_0)
	if arg_16_0._curLevelData and #arg_16_0._curLevelData.points > 0 then
		for iter_16_0, iter_16_1 in ipairs(arg_16_0._curLevelData.points) do
			iter_16_1 = nil
		end
	end

	arg_16_0._copyData = nil
	arg_16_0._curLevelData = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
