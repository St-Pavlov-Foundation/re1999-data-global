-- chunkname: @modules/logic/survival/util/SurvivalHelper.lua

module("modules.logic.survival.util.SurvivalHelper", package.seeall)

local SurvivalHelper = class("SurvivalHelper")
local sqrt3 = math.sqrt(3)
local zeroV3 = Vector3()

function SurvivalHelper:getDistance(a, b)
	return (math.abs(a.q - b.q) + math.abs(a.r - b.r) + math.abs(a.s - b.s)) / 2
end

function SurvivalHelper:getAllPointsByDis(point, dis)
	if not dis or not point or dis <= 0 then
		return {}
	end

	local list = {}
	local len = 0

	for q = -dis, dis do
		for r = -dis, dis do
			for s = -dis, dis do
				if q + r + s == 0 then
					len = len + 1

					local node = SurvivalMapModel.instance:getCacheHexNode(len)

					node:set(q + point.q, r + point.r, s + point.s)
					table.insert(list, node)
				end
			end
		end
	end

	return list
end

function SurvivalHelper:hexPointToWorldPoint(q, r)
	return r / 4 * sqrt3 + q * sqrt3 / 2, 0, -r * 3 / 4
end

function SurvivalHelper:worldPointToHex(x, y, z)
	local q = (z + x * sqrt3) * 2 / 3
	local r = -z * 4 / 3
	local s = -q - r
	local roundQ = Mathf.Round(q)
	local roundR = Mathf.Round(r)
	local roundS = Mathf.Round(s)
	local absQ = math.abs(q - roundQ)
	local absR = math.abs(r - roundR)
	local absS = math.abs(s - roundS)

	if absR < absQ and absS < absQ then
		roundQ = -roundR - roundS
	elseif absS < absR then
		roundR = -roundQ - roundS
	else
		roundS = -roundQ - roundR
	end

	return roundQ, roundR, roundS
end

function SurvivalHelper:getScene3DPos(screenPos, yPos)
	yPos = yPos or 0
	screenPos = screenPos or GamepadController.instance:getMousePosition()

	local mainCamera = CameraMgr.instance:getMainCamera()
	local ray = mainCamera:ScreenPointToRay(screenPos)
	local dir = ray.direction

	if dir.y == 0 then
		return zeroV3
	end

	local origin = ray.origin
	local num = -(origin.y - yPos) / dir.y

	return origin:Add(dir:Mul(num))
end

function SurvivalHelper:getDir(fromPos, toPos)
	local q = toPos.q - fromPos.q
	local r = toPos.r - fromPos.r
	local max_val = math.max(math.abs(q), math.abs(r))
	local base_q, base_r = math.floor(q / max_val), math.floor(r / max_val)

	for dir, pos in pairs(SurvivalEnum.DirToPos) do
		if pos.q == base_q and pos.r == base_r then
			return dir
		end
	end

	logError("not dir! " .. tostring(fromPos) .. " " .. tostring(toPos))
end

function SurvivalHelper:screenPosToRay(screenPos)
	screenPos = screenPos or GamepadController.instance:getMousePosition()

	local camera = CameraMgr.instance:getMainCamera()
	local ray = camera:ScreenPointToRay(screenPos)

	return ray
end

function SurvivalHelper:isInSeasonAndVersion(co)
	if not co then
		return false
	end

	local outSideMo = SurvivalModel.instance:getOutSideInfo()

	if not outSideMo then
		return false
	end

	local needVersions = co.versions

	if not string.nilorempty(needVersions) then
		local list = GameUtil.splitString2(needVersions, true)

		for _, versions in ipairs(list) do
			table.sort(versions)

			if not self:isSame(versions, outSideMo.versions) then
				return false
			end
		end
	end

	local needSeasons = co.seasons

	if not string.nilorempty(needSeasons) then
		local arr = string.splitToNumber(needSeasons, "#")

		if not tabletool.indexOf(arr, outSideMo.season) then
			return false
		end
	end

	return true
end

function SurvivalHelper:isSame(arrA, arrB)
	if not arrA or not arrB then
		return false
	end

	if #arrA ~= #arrB then
		return false
	end

	for k, v in ipairs(arrA) do
		if arrB[k] ~= v then
			return false
		end
	end

	return true
end

function SurvivalHelper:makeArrFull(arr, empty, row, col)
	local min = row * col
	local len = #arr

	if len < min then
		for i = len + 1, min do
			table.insert(arr, empty)
		end
	else
		local num = len % col

		if num ~= 0 then
			for i = num + 1, col do
				table.insert(arr, empty)
			end
		end
	end
end

function SurvivalHelper:getOperResult(oper, num1, num2)
	if oper == SurvivalEnum.ConditionOper.GE then
		return num2 <= num1
	elseif oper == SurvivalEnum.ConditionOper.EQ then
		return num1 == num2
	elseif oper == SurvivalEnum.ConditionOper.LE then
		return num1 <= num2
	end
end

function SurvivalHelper:fitlterPath(path)
	if not path or #path < 3 then
		return path
	end

	local newPath = {
		path[1]
	}
	local prevDir = self:getDir(path[1], path[2])

	for i = 2, #path - 1 do
		local currentDir = self:getDir(path[i], path[i + 1])

		if currentDir ~= prevDir then
			table.insert(newPath, path[i])

			prevDir = currentDir
		end
	end

	table.insert(newPath, path[#path])

	return newPath
end

function SurvivalHelper:addNodeToDict(dict, node, value)
	if not dict[node.q] then
		dict[node.q] = {}
	end

	if value == nil then
		value = node
	end

	dict[node.q][node.r] = value
end

function SurvivalHelper:removeNodeToDict(dict, node)
	if not dict[node.q] then
		return
	end

	dict[node.q][node.r] = nil
end

function SurvivalHelper:isHaveNode(dict, node)
	if not dict[node.q] then
		return nil
	end

	return dict[node.q][node.r] ~= nil
end

function SurvivalHelper:getValueFromDict(dict, node)
	if not dict[node.q] then
		return nil
	end

	return dict[node.q][node.r]
end

function SurvivalHelper:getDirMustHave(fromPos, toPos)
	local q = toPos.q - fromPos.q
	local r = toPos.r - fromPos.r
	local max_val = math.max(math.abs(q), math.abs(r))
	local base_q, base_r = math.floor(q / max_val), math.floor(r / max_val)

	for dir, pos in pairs(SurvivalEnum.DirToPos) do
		if pos.q == base_q and pos.r == base_r then
			return dir
		end
	end

	return SurvivalEnum.Dir.Right
end

function SurvivalHelper:createLuaSimpleListComp(gameObject, listScrollParam, res, viewContainer)
	local list = MonoHelper.addNoUpdateLuaComOnceToGo(gameObject, SurvivalSimpleListComp, {
		listScrollParam = listScrollParam,
		viewContainer = viewContainer
	})

	list:setRes(res)

	return list
end

SurvivalHelper.instance = SurvivalHelper.New()

return SurvivalHelper
