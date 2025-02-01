module("modules.common.res.ResMgr", package.seeall)

slot0 = _M
slot1 = {}
slot2 = {}
slot3 = {}
slot4 = {}
slot5 = 0
slot6 = nil

function slot0.getAbAsset(slot0, slot1, slot2, slot3)
	if uv0[slot3] then
		if slot0 == uv0[slot3].url then
			return slot3
		end

		uv1[slot4][slot3] = nil

		uv2._getCBPool():putObject(uv0[slot3])

		uv0[slot3] = nil
	end

	if uv3[slot0] then
		slot1(slot2, slot4)
	else
		uv4 = uv4 + 1
		slot5 = uv2._getCBPool():getObject()
		slot5.callback = slot1
		slot5.url = slot0
		slot5.id = uv4

		slot5:setCbObj(slot2)

		uv0[uv4] = slot5

		if not uv1[slot0] then
			uv1[slot0] = {}
		end

		uv1[slot0][uv4] = slot5

		loadAbAsset(slot0, false, _onLoadCallback)

		if not uv3[slot0] then
			return uv4
		end
	end
end

function slot0._getCBPool()
	if not uv0 then
		uv0 = LuaObjPool.New(200, LuaGeneralCallback._poolNew, LuaGeneralCallback._poolRelease, LuaGeneralCallback._poolReset)
	end

	return uv0
end

function slot0.removeCallBack(slot0)
	if uv0[slot0] then
		uv1[uv0[slot0].url][slot0] = nil

		uv2._getCBPool():putObject(uv0[slot0])

		uv0[slot0] = nil
	end
end

function slot0.removeAsset(slot0)
	uv0[slot0:getUrl()] = nil

	table.insert(uv1, slot0)
end

function slot0.ReleaseObj(slot0)
	if slot0 and gohelper.isNil(slot0) == false then
		if MonoHelper.getLuaComFromGo(slot0, AssetInstanceComp) then
			slot1:onDestroy()
			MonoHelper.removeLuaComFromGo(slot0, AssetInstanceComp)
		end

		gohelper.destroy(slot0)
	end
end

function slot0._onLoadCallback(slot0)
	slot1 = slot0.AssetUrl
	slot2 = _getAssetMO(slot0, slot1)

	if uv0[slot1] then
		for slot7, slot8 in pairs(slot3) do
			uv1[slot7] = nil

			slot8:invoke(slot2)
			uv2._getCBPool():putObject(slot8)
		end
	end

	uv0[slot1] = nil
end

function slot0.getAssetPool()
	return uv0
end

function slot0._getAssetMO(slot0, slot1)
	if uv0[slot1] == nil then
		if table.remove(uv1) == nil then
			slot3 = AssetMO.New(slot0)
		else
			slot3:setAssetItem(slot0)
		end

		uv0[slot1] = slot3
	end

	return uv0[slot1]
end

return slot0
