module("modules.logic.rouge.controller.RougeCollectionDebugHelper", package.seeall)

slot0 = _M

function slot0.checkCollectionStaticItmeCfgs()
	if not isDebugBuild then
		return
	end

	if RougeCollectionConfig.instance:getAllItemStaticDescCfgs() then
		for slot4, slot5 in ipairs(slot0) do
			RougeCollectionDescHelper.setCollectionDescInfos3(slot5.id, {
				tonumber(slot5.item1),
				tonumber(slot5.item2),
				tonumber(slot5.item3)
			})
		end
	end
end

function slot0.checkCollectionDescCfgs()
	if not isDebugBuild then
		return
	end

	slot0 = {}

	if RougeCollectionConfig.instance:getAllCollectionDescCfgs() then
		for slot5, slot6 in ipairs(slot1) do
			RougeCollectionExpressionHelper.getDescExpressionResult(slot6.desc, slot0)
		end
	end
end

return slot0
