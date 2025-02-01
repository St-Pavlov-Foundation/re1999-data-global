module("modules.logic.fight.entity.pool.FightSpinePool", package.seeall)

slot0 = class("FightSpinePool")
slot1 = {}
slot2 = {}

function slot0.getSpine(slot0)
	if not uv0[slot0] then
		uv0[slot0] = LuaObjPool.New(3, function ()
			if uv0[uv1] then
				return gohelper.clone(slot0:GetResource())
			end
		end, uv2._releaseFunc, uv2._resetFunc)
	end

	return slot1:getObject()
end

function slot0.putSpine(slot0, slot1)
	if uv0[slot0] then
		slot2:putObject(slot1)
	end
end

function slot0.setAssetItem(slot0, slot1)
	uv0[slot0] = slot1
end

function slot0.dispose()
	for slot3, slot4 in pairs(uv0) do
		uv1.releaseUrl(slot3)
	end

	for slot3, slot4 in pairs(uv2) do
		uv2[slot3] = nil
	end

	uv0 = {}
	uv2 = {}
end

function slot0._releaseFunc(slot0)
	if slot0 then
		gohelper.destroy(slot0)
	end
end

function slot0._resetFunc(slot0)
	if slot0 then
		gohelper.setActive(slot0, false)
		gohelper.addChild(GameSceneMgr.instance:getScene(SceneType.Fight).entityMgr:getEntityContainer(), slot0)
		transformhelper.setLocalPos(slot0.transform, 0, 0, 0)
		transformhelper.setLocalScale(slot0.transform, 1, 1, 1)
		transformhelper.setLocalRotation(slot0.transform, 0, 0, 0)
	end
end

function slot0.releaseUrl(slot0)
	if uv0 and uv0[slot0] then
		slot1:dispose()

		uv0[slot0] = nil
	end

	if uv1 and uv1[slot0] then
		uv1[slot0] = nil
	end
end

return slot0
