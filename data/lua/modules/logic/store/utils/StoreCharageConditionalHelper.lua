-- chunkname: @modules/logic/store/utils/StoreCharageConditionalHelper.lua

local StoreCharageConditionalHelper = {}

StoreCharageConditionalHelper._conditionFunction = nil

function StoreCharageConditionalHelper._getFuncDict()
	if not StoreCharageConditionalHelper._conditionFunction then
		StoreCharageConditionalHelper._conditionFunction = {
			HasHero = function(goodsId, conCfg)
				local heroIds
				local maxProgress = conCfg and conCfg.maxProgress or 1

				if conCfg and not string.nilorempty(conCfg.listenerParam) then
					heroIds = string.splitToNumber(conCfg.listenerParam, "#")
				end

				if heroIds then
					local progeress = 0

					for _, heroId in ipairs(heroIds) do
						local heroMo = HeroModel.instance:getByHeroId(heroId)

						if heroMo and heroMo:isOwnHero() then
							progeress = progeress + 1
						end

						if maxProgress <= progeress then
							return true
						end
					end
				end

				return false
			end
		}
	end

	return StoreCharageConditionalHelper._conditionFunction
end

function StoreCharageConditionalHelper.isCharageCondition(goodsId)
	local condCfg = StoreConfig.instance:findChargeConditionalConfigByGoodsId(goodsId)

	if condCfg then
		local listenerType = condCfg.listenerType
		local funcDict = StoreCharageConditionalHelper._getFuncDict()
		local func = funcDict[listenerType]

		if func then
			return func(goodsId, condCfg)
		else
			logError(string.format("goodsId:%s taskid:%s can not find linstnerType function", goodsId, condCfg.goodsId))
		end

		return false
	end

	return true
end

function StoreCharageConditionalHelper.isCharageTaskFinish(goodsId)
	local cfg = StoreConfig.instance:getChargeGoodsConfig(goodsId, true)

	if cfg and cfg.taskid ~= 0 then
		local taskMO = TaskModel.instance:getTaskById(tonumber(cfg.taskid))

		if taskMO and taskMO:isFinished() and taskMO:isClaimed() then
			return true
		end
	end

	return false
end

function StoreCharageConditionalHelper.isCharageTaskNotFinish(goodsId)
	local cfg = StoreConfig.instance:getChargeGoodsConfig(goodsId, true)

	if cfg and cfg.taskid ~= 0 then
		local taskMO = TaskModel.instance:getTaskById(tonumber(cfg.taskid))

		if not taskMO or not taskMO:isFinished() or not taskMO:isClaimed() then
			return true
		end
	end

	return false
end

function StoreCharageConditionalHelper.isHasCanFinishGoodsTask(goodsId)
	local storePackageGoodsMO = StoreModel.instance:getGoodsMO(goodsId)

	if storePackageGoodsMO and storePackageGoodsMO.buyCount > 0 and StoreCharageConditionalHelper.isCharageTaskNotFinish(goodsId) and StoreCharageConditionalHelper.isCharageCondition(goodsId) then
		return true
	end

	return false
end

return StoreCharageConditionalHelper
