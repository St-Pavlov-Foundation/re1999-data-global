-- chunkname: @modules/logic/rouge2/backpack/model/rpcmo/Rouge2_BagInfoMO.lua

module("modules.logic.rouge2.backpack.model.rpcmo.Rouge2_BagInfoMO", package.seeall)

local Rouge2_BagInfoMO = pureTable("Rouge2_BagInfoMO")

function Rouge2_BagInfoMO:init(info)
	if info then
		self._bagMap = GameUtil.rpcInfosToMap(info.bags, Rouge2_BagMO, "_bagType")
	else
		self._bagMap = {}
	end
end

function Rouge2_BagInfoMO:getBag(bagType)
	return self._bagMap and self._bagMap[bagType]
end

function Rouge2_BagInfoMO:removeItems(itemInfoList)
	for _, itemInfo in ipairs(itemInfoList) do
		local uid = itemInfo.uid
		local bagType = Rouge2_BackpackHelper.uid2BagType(uid)
		local bagMo = self:getBag(bagType)

		if bagMo then
			bagMo:removeItem(itemInfo)
		end
	end
end

function Rouge2_BagInfoMO:updateItems(itemInfoList)
	for _, itemInfo in ipairs(itemInfoList) do
		local uid = itemInfo.uid
		local bagType = Rouge2_BackpackHelper.uid2BagType(uid)
		local bagMo = self:getBag(bagType)

		if not bagMo then
			bagMo = Rouge2_BagMO.New()

			bagMo:init({
				bagType = bagType
			})

			self._bagMap[bagType] = bagMo
		end

		if bagMo then
			bagMo:updateItem(itemInfo)
		end
	end
end

return Rouge2_BagInfoMO
