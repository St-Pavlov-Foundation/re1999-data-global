local var_0_0 = string.format
local var_0_1 = table.insert
local var_0_2 = string.rep
local var_0_3 = require("modules.logic.gm.gaosiniao.ser")
local var_0_4 = require("modules.logic.gm.gaosiniao.readonly")
local var_0_5 = require("modules.logic.gm.gaosiniao.reverse_define")
local var_0_6 = Bitwise

GaoSiNiaoEnum.GridType._edit_BagPath = GaoSiNiaoEnum.GridType.__End + 1
GaoSiNiaoEnum.rZoneMask = var_0_5(GaoSiNiaoEnum, "ZoneMask")
GaoSiNiaoEnum.rGridType = var_0_5(GaoSiNiaoEnum, "GridType")
GaoSiNiaoEnum.rPathType = var_0_5(GaoSiNiaoEnum, "PathType")
GaoSiNiaoEnum.rPathInfo = var_0_5(GaoSiNiaoEnum, "PathInfo")
GaoSiNiaoEnum.rPathSpriteId = var_0_5(GaoSiNiaoEnum, "PathSpriteId")

function GaoSiNiaoEnum._edit_nameOfGridType(arg_1_0)
	local var_1_0 = GaoSiNiaoEnum.GridType

	if arg_1_0 == var_1_0.Empty then
		return "空地"
	elseif arg_1_0 == var_1_0.Start then
		return "起点"
	elseif arg_1_0 == var_1_0.End then
		return "终点"
	elseif arg_1_0 == var_1_0.Wall then
		return "墙"
	elseif arg_1_0 == var_1_0.Portal then
		return "传送门"
	elseif arg_1_0 == var_1_0.Path then
		return "固定路径"
	elseif arg_1_0 == var_1_0._edit_BagPath then
		return "(Edit) 背包路径"
	else
		assert(false, "unsupported GaoSiNiaoEnum.GridType : " .. tostring(arg_1_0))
	end
end

function GaoSiNiaoEnum._edit_nameOfPathType(arg_2_0)
	local var_2_0 = GaoSiNiaoEnum.PathType

	if arg_2_0 == var_2_0.RB then
		return "→↓"
	elseif arg_2_0 == var_2_0.LT then
		return "←↑"
	elseif arg_2_0 == var_2_0.LRTB then
		return "↑→↓←"
	elseif arg_2_0 == var_2_0.TB then
		return "↑↓"
	elseif arg_2_0 == var_2_0.LB then
		return "←↓"
	elseif arg_2_0 == var_2_0.RT then
		return "↑→"
	elseif arg_2_0 == var_2_0.LR then
		return "←→"
	elseif arg_2_0 == var_2_0.LTB then
		return "←↑↓"
	elseif arg_2_0 == var_2_0.RTB then
		return "↑↓→"
	elseif arg_2_0 == var_2_0.LRB then
		return "←↓→"
	elseif arg_2_0 == var_2_0.LRT then
		return "←↑→"
	else
		assert(false, "unsupported GaoSiNiaoEnum.PathType : " .. tostring(arg_2_0))
	end
end

local var_0_7 = "#00FF00"
local var_0_8 = "#FFFFFF"
local var_0_9 = "#FFFF00"
local var_0_10 = "#FF0000"
local var_0_11 = "#0000FF"
local var_0_12 = "#FFFFFF"
local var_0_13 = "#000000"

local function var_0_14(arg_3_0, arg_3_1)
	if arg_3_0 ~= nil and type(arg_3_0) ~= "string" then
		arg_3_0 = tostring(arg_3_0)
	end

	if string.nilorempty(arg_3_0) then
		arg_3_0 = "[None]"
	end

	return gohelper.getRichColorText(arg_3_0, arg_3_1 or var_0_12)
end

local function var_0_15(arg_4_0)
	if type(arg_4_0) ~= "table" then
		return true
	end

	return not (next(arg_4_0) or #arg_4_0 > 0)
end

local var_0_16 = require("modules.logic.versionactivity3_1.gaosiniao.model.GaoSiNiaoBattleModel")
local var_0_17 = require("modules.logic.versionactivity3_1.gaosiniao.model.GaoSiNiaoBattleMapMO")
local var_0_18 = require("modules.logic.versionactivity3_1.gaosiniao.model.GaoSiNiaoMapInfo")
local var_0_19 = require("modules.logic.versionactivity3_1.gaosiniao.model.GaoSiNiaoMapBag")

module("modules.logic.gm.gaosiniao.GaoSiNiaoBattleMapMO__Edit", package.seeall)

local var_0_20 = class("GaoSiNiaoBattleMapMO__Edit", var_0_17)
local var_0_21 = "Assets/ZProj/Scripts/Lua/modules/configs/gaosiniao"
local var_0_22 = "GaoSiNiaoBattleMapMO"
local var_0_23 = "GaoSiNiaoBattleMapMO__Edit"
local var_0_24 = {
	Runtime = var_0_6["<<"](1, 0),
	Edit = var_0_6["<<"](1, 1)
}
local var_0_25 = {
	Unknown = -1,
	R2R = var_0_6["|"](var_0_24.Runtime, var_0_24.Runtime),
	R2E = var_0_6["|"](var_0_24.Edit, var_0_24.Runtime),
	E2R = var_0_6["|"](var_0_24.Runtime, var_0_24.Edit),
	E2E = var_0_6["|"](var_0_24.Edit, var_0_24.Edit)
}

local function var_0_26(arg_5_0)
	if arg_5_0 == var_0_22 then
		return var_0_24.Runtime
	elseif arg_5_0 == var_0_23 then
		return var_0_24.Edit
	else
		assert(false, "unsupported clsName: " .. tostring(arg_5_0))
	end
end

local function var_0_27(arg_6_0)
	if arg_6_0 == var_0_22 then
		return "Game"
	elseif arg_6_0 == var_0_23 then
		return "Edit"
	else
		assert(false, "unsupported clsName: " .. tostring(arg_6_0))
	end
end

local function var_0_28(arg_7_0, arg_7_1)
	local var_7_0 = 0
	local var_7_1 = var_0_6["|"](var_7_0, var_0_26(arg_7_0.class.__cname))

	return (var_0_6["|"](var_7_1, var_0_26(arg_7_1.class.__cname)))
end

function var_0_20.default_ctor(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = var_0_20.New()

	var_8_0.__info = var_0_18.New(arg_8_2 or GaoSiNiaoEnum.Version.V1_0_0)
	arg_8_0[arg_8_1] = var_8_0
end

function var_0_20.move_ctor(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = assert(arg_9_2[arg_9_3])
	local var_9_1 = var_0_20.New()
	local var_9_2 = var_9_0:mapId()
	local var_9_3 = var_9_0.__info._mapCO
	local var_9_4 = var_9_3 and var_9_3.width or false
	local var_9_5 = var_9_3 and var_9_3.height or false
	local var_9_6 = var_9_3 and var_9_3.gridList or {}
	local var_9_7 = var_9_3 and var_9_3.bagList or {}
	local var_9_8 = var_0_28(var_9_0, var_9_1)
	local var_9_9 = var_9_8 == var_0_25.R2E
	local var_9_10 = var_9_8 == var_0_25.E2E
	local var_9_11 = var_9_9 or var_9_10

	var_9_1.__info = var_9_0.__info

	if var_9_11 then
		local var_9_12 = {
			id = var_9_2,
			width = var_9_4,
			height = var_9_5,
			gridList = var_9_6,
			bagList = var_9_10 and var_9_7 or {}
		}

		var_9_1.__info._mapCO = var_9_12
	end

	var_9_1._pt2BagDict = var_9_0._pt2BagDict

	if var_9_9 then
		for iter_9_0, iter_9_1 in pairs(GaoSiNiaoEnum.PathType) do
			if iter_9_1 ~= GaoSiNiaoEnum.PathType.__End and iter_9_1 ~= GaoSiNiaoEnum.PathType.None then
				var_9_1._pt2BagDict[iter_9_1] = var_0_19.New(var_9_1, iter_9_1, 0)
			end
		end
	end

	var_9_1._gridList = var_9_0._gridList
	arg_9_2[arg_9_3] = nil
	arg_9_0[arg_9_1] = var_9_1
end

function var_0_20._edit_showMsgBoxIfFailed(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 then
		MessageBoxController.instance:showMsgBoxByStr(arg_10_2, MsgBoxEnum.BoxType.Yes)
	end

	return arg_10_1
end

function var_0_20.__edit_getMapCOToSave(arg_11_0)
	local var_11_0 = {}
	local var_11_1 = {}

	for iter_11_0, iter_11_1 in pairs(arg_11_0._pt2BagDict) do
		if iter_11_1.count > 0 then
			var_11_1[iter_11_0] = iter_11_1.count
		end
	end

	local var_11_2 = {}

	arg_11_0:foreachGrid(function(arg_12_0, arg_12_1)
		var_11_2[arg_12_1] = arg_11_0.__info:make_gridCO(arg_12_0.type, arg_12_0.ePathType, arg_12_0.bMovable, arg_12_0.zRot)
	end)

	local var_11_3 = {}

	for iter_11_2, iter_11_3 in pairs(var_11_1) do
		var_0_1(var_11_3, arg_11_0.__info:make_bagCO(iter_11_2, iter_11_3))
	end

	local var_11_4, var_11_5 = arg_11_0:mapSize()

	var_11_0.id = arg_11_0:mapId()
	var_11_0.width = var_11_4
	var_11_0.height = var_11_5
	var_11_0.bagList = var_11_3
	var_11_0.gridList = var_11_2

	return var_11_0
end

function var_0_20._edit_getGridItemListIndexStr(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if var_0_15(arg_13_3) then
		return
	end

	arg_13_2 = arg_13_2 or 0

	local var_13_0 = var_0_2("\t", arg_13_2)

	var_0_1(arg_13_1, var_13_0)

	for iter_13_0, iter_13_1 in ipairs(arg_13_3) do
		arg_13_1[#arg_13_1 + 1] = arg_13_1[#arg_13_1 + 1] .. " " .. iter_13_1:indexStr()
	end
end

function var_0_20._edit_checkValidMap(arg_14_0)
	local var_14_0 = arg_14_0:__edit_getMapCOToSave()
	local var_14_1 = {}

	GaoSiNiaoMapInfo.s_dump_raw(var_14_0, var_14_1)

	do return end

	arg_14_0:_createMap(var_14_0)

	local var_14_2 = true and arg_14_0:_edit_showMsgBoxIfFailed(#arg_14_0._startGridList == 1, "必须要仅有一个起点")

	var_14_2 = var_14_2 and arg_14_0:_edit_showMsgBoxIfFailed(#arg_14_0._endGridList == 1, "必须至少有一个终点")
	var_14_2 = var_14_2 and arg_14_0:_edit_showMsgBoxIfFailed(#arg_14_0._portalGridList == 0 or #arg_14_0._portalGridList == 2, string.format("传送门只能0个或者1对, 目前有%s个", arg_14_0._portalGridList))
	var_14_2 = var_14_2 and arg_14_0:_edit_showMsgBoxIfFailed(arg_14_0:isCompleted(), "起点无法到达终点")

	return var_14_2
end

function var_0_20._edit_confirmSaveOrNot(arg_15_0, arg_15_1, arg_15_2)
	if not arg_15_0:_edit_checkValidMap() then
		if arg_15_1 then
			arg_15_1(arg_15_2)
		end

		return
	end

	MessageBoxController.instance:showMsgBoxByStr("Save?", MsgBoxEnum.BoxType.Yes_No, function()
		arg_15_0:_edit_saveMap()

		if arg_15_1 then
			arg_15_1(arg_15_2)
		end
	end, arg_15_1, nil, arg_15_2, arg_15_2, arg_15_2)
end

function var_0_20._edit_saveMap(arg_17_0)
	arg_17_0.__info:_edit_saveMap(arg_17_0:__edit_getMapCOToSave())
end

function var_0_17.move_ctor(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = assert(arg_18_2[arg_18_3])
	local var_18_1 = GaoSiNiaoBattleMapMO.New()
	local var_18_2 = var_18_0:mapId()
	local var_18_3 = var_18_0.__info
	local var_18_4 = var_18_3.version
	local var_18_5 = var_18_3._mapCO
	local var_18_6 = var_18_5 and var_18_5.width or false
	local var_18_7 = var_18_5 and var_18_5.height or false
	local var_18_8 = var_18_5 and var_18_5.gridList or {}
	local var_18_9 = var_18_5 and var_18_5.bagList or {}
	local var_18_10 = var_0_28(var_18_0, var_18_1)
	local var_18_11 = var_18_10 == var_0_25.R2R
	local var_18_12 = var_18_10 == var_0_25.E2R
	local var_18_13 = var_18_11 or var_18_12

	var_18_1.__info = var_18_0.__info

	local var_18_14 = false

	if var_18_13 then
		local var_18_15 = {
			id = var_18_2,
			width = var_18_6,
			height = var_18_7,
			gridList = var_18_8,
			bagList = var_18_11 and var_18_9 or {}
		}

		if var_18_12 then
			local var_18_16 = {}

			for iter_18_0, iter_18_1 in ipairs(var_18_9) do
				if iter_18_1.count > 0 then
					var_18_16[iter_18_1.ptype] = var_18_16[iter_18_1.ptype] or 0
					var_18_16[iter_18_1.ptype] = var_18_16[iter_18_1.ptype] + iter_18_1.count
				end
			end

			if next(var_18_16) then
				for iter_18_2, iter_18_3 in pairs(var_18_16) do
					var_0_1(var_18_15.bagList, var_18_0.__info:make_bagCO(iter_18_2, iter_18_3))
				end
			else
				var_18_3._mapCO = nil
				var_18_15.bagList = var_18_3:mapCO().bagList
				var_18_14 = true
			end
		end

		var_18_1.__info._mapCO = var_18_15
	end

	var_18_1._pt2BagDict = var_18_0._pt2BagDict

	if var_18_12 then
		for iter_18_4, iter_18_5 in pairs(var_18_1._pt2BagDict) do
			if iter_18_5.count <= 0 then
				var_18_1._pt2BagDict[iter_18_5.type] = nil
			end
		end
	end

	if var_18_14 then
		var_18_1:_createBags(var_18_1.__info._mapCO)
	end

	var_18_1._gridList = var_18_0._gridList
	arg_18_2[arg_18_3] = nil
	arg_18_0[arg_18_1] = var_18_1
end

function var_0_18._edit_getMapConfigAssetPath(arg_19_0)
	return var_0_21 .. "/map_" .. arg_19_0.version .. ".lua"
end

function var_0_18._edit_saveMap(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0:_getMapRequireLuaPath()
	local var_20_1 = require(var_20_0)
	local var_20_2 = false

	for iter_20_0, iter_20_1 in ipairs(var_20_1) do
		if iter_20_1.id == arg_20_1.id then
			var_20_1[iter_20_0] = arg_20_1
			var_20_2 = true

			break
		end
	end

	if not var_20_2 then
		var_0_1(var_20_1, arg_20_1)
	end

	arg_20_0:_edit_saveAllMaps(var_20_1)
end

function var_0_18._edit_saveAllMaps(arg_21_0, arg_21_1)
	do return end

	local var_21_0 = var_0_3(arg_21_1)
	local var_21_1 = arg_21_0:_edit_getMapConfigAssetPath()

	SLFramework.FileHelper.WriteTextToPath(var_21_1, var_21_0)
	logError("[GaoSiNiao] Save As: " .. tostring(var_21_1))

	local var_21_2 = arg_21_0:_getMapRequireLuaPath()

	package.loaded[var_21_2] = nil
end

function var_0_16.dump(arg_22_0, arg_22_1, arg_22_2)
	arg_22_2 = arg_22_2 or 0

	local var_22_0 = var_0_2("\t", arg_22_2)
	local var_22_1 = var_0_14(var_0_27(arg_22_0._mapMO.class.__cname), var_0_9)

	var_0_1(arg_22_1, var_22_0 .. var_0_0("Mode: %s", var_22_1))

	local var_22_2 = arg_22_0:episodeId()

	var_0_1(arg_22_1, var_22_0 .. var_0_0("episodeId: %s", var_22_2))
	var_0_1(arg_22_1, var_22_0 .. "MapMO:")
	arg_22_0._mapMO:dump(arg_22_1, arg_22_2 + 1)
end

function var_0_17.dump(arg_23_0, arg_23_1, arg_23_2)
	arg_23_2 = arg_23_2 or 0

	local var_23_0 = var_0_2("\t", arg_23_2)

	var_0_1(arg_23_1, var_23_0 .. "__info:")
	arg_23_0.__info:dump(arg_23_1, arg_23_2 + 1)
	var_0_1(arg_23_1, var_23_0 .. "BagInfo:")

	if next(arg_23_0._pt2BagDict) then
		for iter_23_0 = GaoSiNiaoEnum.PathType.None + 1, GaoSiNiaoEnum.PathType.__End - 1 do
			local var_23_1 = arg_23_0._pt2BagDict[iter_23_0]

			if var_23_1 then
				var_23_1:dump(arg_23_1, arg_23_2 + 1)
			end
		end
	else
		var_0_1(arg_23_1, var_23_0 .. var_23_0 .. "Invalid")
	end

	var_0_1(arg_23_1, var_23_0 .. "GridInfo:")

	local var_23_2 = var_0_2("\t", arg_23_2 + 1)

	if next(arg_23_0._gridList) then
		local var_23_3, var_23_4 = arg_23_0:rowCol()

		var_0_1(arg_23_1, var_23_2 .. "  ")

		for iter_23_1 = 0, var_23_4 - 1 do
			arg_23_1[#arg_23_1] = arg_23_1[#arg_23_1] .. " " .. var_0_14(iter_23_1, var_0_9)
		end

		arg_23_1[#arg_23_1] = arg_23_1[#arg_23_1] .. " " .. var_0_14("X", var_0_9)

		local var_23_5 = -1

		arg_23_0:foreachGrid(function(arg_24_0)
			local var_24_0 = arg_24_0:x()
			local var_24_1 = arg_24_0:y()
			local var_24_2 = "*"

			if arg_24_0:_isConnedStart() then
				var_24_2 = var_0_14(var_24_2, var_0_7)
			elseif arg_24_0:isWall() then
				var_24_2 = var_0_14(var_24_2, var_0_13)
			elseif arg_24_0:isPortal() then
				var_24_2 = var_0_14(var_24_2, var_0_11)
			end

			if var_23_5 == var_24_1 then
				arg_23_1[#arg_23_1] = arg_23_1[#arg_23_1] .. " " .. var_24_2
			else
				var_0_1(arg_23_1, var_23_2 .. var_0_14(var_24_1, var_0_9) .. " " .. var_24_2)
			end

			var_23_5 = var_24_1
		end)
		var_0_1(arg_23_1, var_23_2 .. "Grid Union:")
		var_0_1(arg_23_1, var_23_2 .. "  ")

		for iter_23_2 = 0, var_23_4 - 1 do
			arg_23_1[#arg_23_1] = arg_23_1[#arg_23_1] .. " " .. var_0_14(iter_23_2, var_0_9)
		end

		arg_23_1[#arg_23_1] = arg_23_1[#arg_23_1] .. " " .. var_0_14("X", var_0_9)
		var_23_5 = -1

		arg_23_0:foreachGrid(function(arg_25_0)
			local var_25_0 = arg_25_0:x()
			local var_25_1 = arg_25_0:y()
			local var_25_2 = arg_23_0:rootId(arg_25_0)

			if var_23_5 == var_25_1 then
				arg_23_1[#arg_23_1] = arg_23_1[#arg_23_1] .. " " .. var_25_2
			else
				var_0_1(arg_23_1, var_23_2 .. var_0_14(var_25_1, var_0_9) .. " " .. var_25_2)
			end

			var_23_5 = var_25_1
		end)
	else
		var_0_1(arg_23_1, var_23_2 .. "Invalid")
	end

	var_0_1(arg_23_1, var_23_2 .. var_0_14("Y", var_0_9))

	var_23_2 = var_0_2("\t", arg_23_2)

	if arg_23_0._whoActivedPortalGrid then
		var_0_1(arg_23_1, var_23_2 .. "isActivedPortal: Yes from" .. arg_23_0._whoActivedPortalGrid:indexStr())
	else
		var_0_1(arg_23_1, var_23_2 .. "isActivedPortal: No")
	end
end

function var_0_18.dump(arg_26_0, arg_26_1, arg_26_2)
	arg_26_2 = arg_26_2 or 0

	local var_26_0 = var_0_2("\t", arg_26_2)
	local var_26_1 = arg_26_0.mapId
	local var_26_2, var_26_3 = arg_26_0:mapSize()

	var_0_1(arg_26_1, var_26_0 .. var_0_0("mapId: %s (%sx%s)", var_26_1, var_26_2, var_26_3))
	var_0_1(arg_26_1, var_26_0 .. "bagList:")

	local var_26_4 = arg_26_0:bagList()
	local var_26_5 = var_0_2("\t", arg_26_2 + 1)

	for iter_26_0, iter_26_1 in ipairs(var_26_4) do
		local var_26_6 = iter_26_1.ptype
		local var_26_7 = iter_26_1.count
		local var_26_8 = GaoSiNiaoEnum.rPathType[var_26_6]

		var_0_1(arg_26_1, var_26_5 .. var_0_0("%s: %s", var_26_8, var_26_7))
	end

	local var_26_9 = var_0_2("\t", arg_26_2)

	var_0_1(arg_26_1, var_26_9 .. "gridList:")

	local var_26_10 = arg_26_0:gridList()
	local var_26_11 = var_0_2("\t", arg_26_2 + 1)
	local var_26_12 = 0
	local var_26_13 = 0

	while var_26_12 < var_26_3 do
		local var_26_14 = 0
		local var_26_15 = ""

		while var_26_14 < var_26_2 do
			local var_26_16 = var_26_10[var_26_13].gtype
			local var_26_17 = GaoSiNiaoEnum.rGridType[var_26_16]

			for iter_26_2 = string.len(var_26_17) + 1, 6 do
				var_26_17 = var_26_17 .. " "
			end

			var_26_15 = var_26_15 .. var_0_0("(%s,%s) %s", var_26_14, var_26_12, var_26_17)
			var_26_13 = var_26_13 + 1
			var_26_14 = var_26_14 + 1
		end

		var_0_1(arg_26_1, var_26_11 .. var_26_15)

		var_26_12 = var_26_12 + 1
	end

	local var_26_18 = var_0_2("\t", arg_26_2)
end

function var_0_18.s_dump_raw(arg_27_0, arg_27_1, arg_27_2)
	if type(arg_27_0) ~= "table" then
		return
	end

	local var_27_0 = var_0_18.New(11235)

	var_27_0._mapCO = arg_27_0

	var_27_0:dump(arg_27_1, arg_27_2)
end

function var_0_19.dump(arg_28_0, arg_28_1, arg_28_2)
	arg_28_2 = arg_28_2 or 0

	local var_28_0 = var_0_2("\t", arg_28_2)
	local var_28_1 = arg_28_0.count
	local var_28_2 = GaoSiNiaoEnum.rPathType[arg_28_0.type]

	var_0_1(arg_28_1, var_28_0 .. var_0_0("%s: %s", var_28_2, var_0_14(var_28_1, var_0_7)))
end

function GaoSiNiaoMapGrid._dump_ZoneMask(arg_29_0, arg_29_1, arg_29_2)
	arg_29_2 = arg_29_2 or 0

	local var_29_0 = var_0_2("\t", arg_29_2)

	var_0_1(arg_29_1, var_29_0 .. var_0_0("%s: in=%s, out=%s", arg_29_0:indexStr(), GaoSiNiaoEnum.dirToStr(arg_29_0:in_ZoneMask()), GaoSiNiaoEnum.dirToStr(arg_29_0:out_ZoneMask())))
end

function var_0_18._loadMapConfig(arg_30_0)
	local var_30_0 = arg_30_0:_edit_getMapConfigAssetPath()

	if not SLFramework.FileHelper.IsFileExists(var_30_0) then
		return {}
	end

	local var_30_1 = arg_30_0:_getMapRequireLuaPath()

	return var_0_4(require(var_30_1) or {})
end

return var_0_20
