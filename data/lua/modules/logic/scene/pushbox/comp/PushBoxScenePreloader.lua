module("modules.logic.scene.pushbox.comp.PushBoxScenePreloader", package.seeall)

slot0 = class("PushBoxScenePreloader", BaseSceneComp)

function slot0.onInit(slot0)
	slot0._scene = slot0:getCurScene()
end

function slot0.startPreload(slot0, slot1)
	slot0.loader = MultiAbLoader.New()
	slot5 = "pushboxmainpre"

	slot0.loader:addPath(ResUrl.getPushBoxPre(slot5))

	for slot5, slot6 in pairs(slot0:getElementType2Url()) do
		if not tabletool.indexOf(slot0.loader._pathList, slot6) then
			slot0.loader:addPath(slot6)
		end
	end

	slot0.loader:startLoad(slot0._onAssetLoaded, slot0)
end

function slot0._onAssetLoaded(slot0)
	slot0._scene_obj = gohelper.clone(slot0.loader:getAssetItem(ResUrl.getPushBoxPre("pushboxmainpre")):GetResource(), slot0._scene:getSceneContainerGO())
	slot0._scene_obj.name = "Root"
	slot4 = 0
	slot5 = -5

	transformhelper.setLocalPos(slot0._scene_obj.transform, 0, slot4, slot5)

	for slot4, slot5 in pairs(slot0:getElementType2Url()) do
		gohelper.clone(slot0.loader:getAssetItem(slot5):GetResource(), gohelper.findChild(slot0._scene_obj, "OriginElement")).name = slot4
	end

	gohelper.clone(slot0.loader:getAssetItem(slot0:getElementType2Url().Background):GetResource(), slot0._scene_obj).transform:GetChild(0):GetComponent("MeshRenderer").sortingOrder = -10
	slot3 = CameraMgr.instance:getMainCamera()
	slot3.orthographic = true
	slot3.orthographicSize = 7.5

	slot0._scene.director:onPushBoxAssetLoadFinish()
end

function slot0.getAssetItem(slot0, slot1)
	return slot0.loader:getAssetItem(slot1):GetResource()
end

function slot0.onSceneClose(slot0)
	slot1 = CameraMgr.instance:getMainCamera()
	slot1.orthographicSize = 5
	slot1.orthographic = false

	if slot0.loader then
		slot0.loader:dispose()
	end

	if slot0._scene_obj then
		gohelper.destroy(slot0._scene_obj)
	end
end

function slot0.getElementType2Url(slot0)
	return {
		[PushBoxGameMgr.ElementType.Goal] = ResUrl.getPushBoxPre("men_1x1_a"),
		[PushBoxGameMgr.ElementType.Empty] = ResUrl.getPushBoxPre("diban_a"),
		[PushBoxGameMgr.ElementType.Box] = ResUrl.getPushBoxPre("xiangzi_1x1_a"),
		[PushBoxGameMgr.ElementType.Mechanics] = ResUrl.getPushBoxPre("jiguanup_1x1_a"),
		[PushBoxGameMgr.ElementType.Fan] = ResUrl.getPushBoxPre("paifengshan_1x1_a"),
		[PushBoxGameMgr.ElementType.Road] = ResUrl.getPushBoxPre("diban_a"),
		[PushBoxGameMgr.ElementType.LightUp] = ResUrl.getPushBoxPre("tanzhaodeng_1x1_c"),
		[PushBoxGameMgr.ElementType.LightDown] = ResUrl.getPushBoxPre("tanzhaodeng_1x1_d"),
		[PushBoxGameMgr.ElementType.LightLeft] = ResUrl.getPushBoxPre("tanzhaodeng_1x1_a"),
		[PushBoxGameMgr.ElementType.LightRight] = ResUrl.getPushBoxPre("tanzhaodeng_1x1_b"),
		[PushBoxGameMgr.ElementType.WallUp] = ResUrl.getPushBoxPre("qiang_1x1_a"),
		[PushBoxGameMgr.ElementType.WallPicUp1] = ResUrl.getPushBoxPre("qiang_1x1_b"),
		[PushBoxGameMgr.ElementType.WallPicUp2] = ResUrl.getPushBoxPre("qiang_1x1_c"),
		[PushBoxGameMgr.ElementType.WallRight] = ResUrl.getPushBoxPre("qiang_1x1_e01"),
		[PushBoxGameMgr.ElementType.WallLeft] = ResUrl.getPushBoxPre("qiang_1x1_e"),
		[PushBoxGameMgr.ElementType.WallUpDoublePic1] = ResUrl.getPushBoxPre("qiang_1x2_f"),
		[PushBoxGameMgr.ElementType.WallUpDoublePic2] = ResUrl.getPushBoxPre("qiang_1x2_g"),
		[PushBoxGameMgr.ElementType.WallLeft2] = ResUrl.getPushBoxPre("qiang_1x1_d"),
		[PushBoxGameMgr.ElementType.WallRight2] = ResUrl.getPushBoxPre("qiang_1x1_d01"),
		[PushBoxGameMgr.ElementType.WallCornerTopLeft] = ResUrl.getPushBoxPre("wuyan_1×1_a2"),
		[PushBoxGameMgr.ElementType.WallCornerTopRight] = ResUrl.getPushBoxPre("wuyan_1×1_a1"),
		[PushBoxGameMgr.ElementType.WallCornerBottomLeft] = ResUrl.getPushBoxPre("wuyan_1×1_b2"),
		[PushBoxGameMgr.ElementType.WallCornerBottomRight] = ResUrl.getPushBoxPre("wuyan_1×1_b1"),
		EnemyUp = ResUrl.getPushBoxPre("baoan_1x1_c"),
		EnemyDown = ResUrl.getPushBoxPre("baoan_1x1_d"),
		EnemyLeft = ResUrl.getPushBoxPre("baoan_1x1_a"),
		EnemyRight = ResUrl.getPushBoxPre("baoan_1x1_b"),
		CharacterUp = ResUrl.getPushBoxPre("meilaini_1x1_c"),
		CharacterDown = ResUrl.getPushBoxPre("meilaini_1x1_a"),
		CharacterLeft = ResUrl.getPushBoxPre("meilaini_1x1_b"),
		CharacterRight = ResUrl.getPushBoxPre("meilaini_1x1_d"),
		DoorOpen = ResUrl.getPushBoxPre("men_1x1_b"),
		EnabledMechanics = ResUrl.getPushBoxPre("jiguandown_1x1_a"),
		Background = ResUrl.getPushBoxPre("background"),
		diban_b = ResUrl.getPushBoxPre("diban_b"),
		diban_c = ResUrl.getPushBoxPre("diban_c"),
		diban_d = ResUrl.getPushBoxPre("diban_d")
	}
end

return slot0
