module("modules.logic.scene.pushbox.comp.PushBoxScenePreloader", package.seeall)

local var_0_0 = class("PushBoxScenePreloader", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	arg_1_0._scene = arg_1_0:getCurScene()
end

function var_0_0.startPreload(arg_2_0, arg_2_1)
	arg_2_0.loader = MultiAbLoader.New()

	arg_2_0.loader:addPath(ResUrl.getPushBoxPre("pushboxmainpre"))

	for iter_2_0, iter_2_1 in pairs(arg_2_0:getElementType2Url()) do
		if not tabletool.indexOf(arg_2_0.loader._pathList, iter_2_1) then
			arg_2_0.loader:addPath(iter_2_1)
		end
	end

	arg_2_0.loader:startLoad(arg_2_0._onAssetLoaded, arg_2_0)
end

function var_0_0._onAssetLoaded(arg_3_0)
	arg_3_0._scene_obj = gohelper.clone(arg_3_0.loader:getAssetItem(ResUrl.getPushBoxPre("pushboxmainpre")):GetResource(), arg_3_0._scene:getSceneContainerGO())
	arg_3_0._scene_obj.name = "Root"

	transformhelper.setLocalPos(arg_3_0._scene_obj.transform, 0, 0, -5)

	for iter_3_0, iter_3_1 in pairs(arg_3_0:getElementType2Url()) do
		gohelper.clone(arg_3_0.loader:getAssetItem(iter_3_1):GetResource(), gohelper.findChild(arg_3_0._scene_obj, "OriginElement")).name = iter_3_0
	end

	gohelper.clone(arg_3_0.loader:getAssetItem(arg_3_0:getElementType2Url().Background):GetResource(), arg_3_0._scene_obj).transform:GetChild(0):GetComponent("MeshRenderer").sortingOrder = -10

	local var_3_0 = CameraMgr.instance:getMainCamera()

	var_3_0.orthographic = true
	var_3_0.orthographicSize = 7.5

	arg_3_0._scene.director:onPushBoxAssetLoadFinish()
end

function var_0_0.getAssetItem(arg_4_0, arg_4_1)
	return arg_4_0.loader:getAssetItem(arg_4_1):GetResource()
end

function var_0_0.onSceneClose(arg_5_0)
	local var_5_0 = CameraMgr.instance:getMainCamera()

	var_5_0.orthographicSize = 5
	var_5_0.orthographic = false

	if arg_5_0.loader then
		arg_5_0.loader:dispose()
	end

	if arg_5_0._scene_obj then
		gohelper.destroy(arg_5_0._scene_obj)
	end
end

function var_0_0.getElementType2Url(arg_6_0)
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

return var_0_0
