module("modules.logic.rouge.map.controller.RougeMapDLCResHelper", package.seeall)

slot0 = class("RougeMapDLCResHelper")

function slot0.handleLoadMapDLCRes(slot0, ...)
	if not uv0._getMapDLCResHandle(slot0) then
		return
	end

	slot1(...)
end

function slot0._getMapDLCResHandle(slot0)
	uv0._initHandleLoadMapDLCRes()

	return uv0._mapDLCResLoadHandleMap[slot0]
end

function slot0._loadMapDLCResHandle_101(slot0, slot1)
	slot1.fogPrefab = slot0:getAssetItem(RougeMapEnum.FogMaterialUrl):GetResource()
end

function slot0._initHandleLoadMapDLCRes()
	if not uv0._mapDLCResLoadHandleMap then
		uv0._mapDLCResLoadHandleMap = {
			[RougeDLCEnum.DLCEnum.DLC_101] = uv0._loadMapDLCResHandle_101
		}
	end
end

function slot0.handleCreateMapDLC(slot0, ...)
	if not uv0._getCreateMapDLCHandle(slot0) then
		return
	end

	slot1(...)
end

function slot0._getCreateMapDLCHandle(slot0)
	uv0._initHandleCreateMapDLC()

	return uv0._mapDLCHandleMap[slot0]
end

function slot0._createMapDLCHandle_101(slot0)
	MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.clone(slot0.fogPrefab, gohelper.findChild(slot0.mapGo, "root/BackGround"), "fog"), RougeMapFogEffect)
end

function slot0._initHandleCreateMapDLC()
	if not uv0._mapDLCHandleMap then
		uv0._mapDLCHandleMap = {
			[RougeDLCEnum.DLCEnum.DLC_101] = uv0._createMapDLCHandle_101
		}
	end
end

function slot0.addMapDLCRes(slot0, slot1, slot2)
	uv0._initMapDLCResUrl()

	slot3 = RougeMapHelper._mapDLCResUrlMap[slot0]
	slot4 = {}

	for slot8, slot9 in ipairs(slot1 or {}) do
		for slot14, slot15 in ipairs(slot3 and slot3[slot9] or {}) do
			if not slot4[slot15] then
				slot2:addPath(slot15)

				slot4[slot15] = true
			end
		end
	end
end

function slot0._initMapDLCResUrl()
	if not RougeMapHelper._mapDLCResUrlMap then
		RougeMapHelper._mapDLCResUrlMap = {
			[RougeMapEnum.MapType.Normal] = {
				[RougeDLCEnum.DLCEnum.DLC_101] = {
					RougeMapEnum.FogMaterialUrl
				}
			}
		}
	end
end

return slot0
