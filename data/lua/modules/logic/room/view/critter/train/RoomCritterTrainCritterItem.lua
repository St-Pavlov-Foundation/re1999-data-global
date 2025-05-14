module("modules.logic.room.view.critter.train.RoomCritterTrainCritterItem", package.seeall)

local var_0_0 = class("RoomCritterTrainCritterItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._goshadow = gohelper.create2d(arg_1_1, "critter_shadow")

	gohelper.setAsFirstSibling(arg_1_0._goshadow)
	gohelper.setActive(arg_1_0._goshadow, false)

	arg_1_0._roleSpine = GuiSpine.Create(arg_1_1, false)
	arg_1_0._canvasGroup = gohelper.onceAddComponent(arg_1_1, typeof(UnityEngine.CanvasGroup))

	gohelper.setActive(arg_1_1, true)

	arg_1_0._effs = {}
	arg_1_0._tamingEffs = {}
	arg_1_0._effLoader = MultiAbLoader.New()
	arg_1_0._tamingEffLoader = MultiAbLoader.New()
	arg_1_0._shadowLoader = MultiAbLoader.New()
end

local var_0_1 = {
	"roomcritteremoji1",
	"roomcritteremoji2",
	"roomcritteremoji3",
	"roomcritteremoji4",
	"roomcritteremoji5",
	"roomcritteremoji6"
}

function var_0_0.showByEffectType(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0._critterMo = arg_2_1
	arg_2_0._critterPos = arg_2_2
	arg_2_0._inDialog = arg_2_3

	arg_2_0:_refreshItem()
end

function var_0_0.showByEffectName(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0._critterMo = arg_3_1
	arg_3_0._critterPos = arg_3_2
	arg_3_0._inDialog = arg_3_3

	arg_3_0:_refreshItem()
end

local var_0_2 = "ui/viewres/room/critter/roomcrittershadowitem.prefab"

function var_0_0.showShadow(arg_4_0, arg_4_1)
	gohelper.setActive(arg_4_0._goshadow, arg_4_1)

	if arg_4_1 and not arg_4_0._shadowGo then
		arg_4_0._shadowLoader:addPath(var_0_2)
		arg_4_0._shadowLoader:startLoad(arg_4_0._loadShadowFinished, arg_4_0)
	end
end

function var_0_0._loadShadowFinished(arg_5_0)
	local var_5_0 = arg_5_0._shadowLoader:getAssetItem(var_0_2)

	arg_5_0._shadowGo = gohelper.clone(var_5_0:GetResource(), arg_5_0._goshadow)

	local var_5_1 = gohelper.findChild(arg_5_0._spineGo, "mountroot/mountbottom")
	local var_5_2, var_5_3, var_5_4 = transformhelper.getPos(var_5_1.transform)

	transformhelper.setPos(arg_5_0._shadowGo.transform, var_5_2, var_5_3, var_5_4)
end

function var_0_0.showTamingEffects(arg_6_0, arg_6_1, arg_6_2)
	if LuaUtil.tableNotEmpty(arg_6_0._tamingEffs) then
		for iter_6_0, iter_6_1 in pairs(arg_6_0._tamingEffs) do
			for iter_6_2, iter_6_3 in pairs(iter_6_1.effGos) do
				gohelper.setActive(iter_6_3, arg_6_1)
			end
		end
	else
		local var_6_0 = CritterConfig.instance:getCritterSkinCfg(arg_6_0._critterMo:getSkinId())

		if LuaUtil.isEmptyStr(var_6_0.handEffects) then
			return
		end

		local var_6_1 = string.split(var_6_0.handEffects, ";")

		if not var_6_1[arg_6_2] or LuaUtil.isEmptyStr(var_6_1[arg_6_2]) then
			return
		end

		local var_6_2 = string.split(var_6_1[arg_6_2], "&")

		for iter_6_4, iter_6_5 in pairs(var_6_2) do
			local var_6_3 = string.split(iter_6_5, "|")
			local var_6_4 = {
				root = string.format("mountroot/%s", var_6_3[1]),
				effPaths = {}
			}
			local var_6_5 = string.split(var_6_3[2], "#")

			for iter_6_6, iter_6_7 in ipairs(var_6_5) do
				table.insert(var_6_4.effPaths, iter_6_7)
			end

			table.insert(arg_6_0._tamingEffs, var_6_4)
		end

		arg_6_0:_loadTamingEffects()
	end
end

function var_0_0._loadTamingEffects(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0._tamingEffs) do
		for iter_7_2, iter_7_3 in pairs(iter_7_1.effPaths) do
			local var_7_0 = string.format("effects/prefabs_ui/%s.prefab", iter_7_3)

			arg_7_0._tamingEffLoader:addPath(var_7_0)
		end
	end

	arg_7_0._tamingEffLoader:startLoad(arg_7_0._loadTamingEffsResFinish, arg_7_0)
end

function var_0_0._loadTamingEffsResFinish(arg_8_0)
	for iter_8_0 = 1, #arg_8_0._tamingEffs do
		arg_8_0._tamingEffs[iter_8_0].effGos = {}

		for iter_8_1, iter_8_2 in pairs(arg_8_0._tamingEffs[iter_8_0].effPaths) do
			local var_8_0 = string.format("effects/prefabs_ui/%s.prefab", iter_8_2)
			local var_8_1 = arg_8_0._tamingEffLoader:getAssetItem(var_8_0)
			local var_8_2 = gohelper.findChild(arg_8_0._spineGo, arg_8_0._tamingEffs[iter_8_0].root)
			local var_8_3 = gohelper.clone(var_8_1:GetResource(), var_8_2)

			table.insert(arg_8_0._tamingEffs[iter_8_0].effGos, var_8_3)
		end
	end
end

function var_0_0.setEffectByName(arg_9_0, arg_9_1)
	arg_9_0._critterEffType = 0

	for iter_9_0, iter_9_1 in ipairs(var_0_1) do
		if string.find(arg_9_1, iter_9_1) then
			arg_9_0._critterEffType = iter_9_0
		end
	end
end

function var_0_0.setEffectByType(arg_10_0, arg_10_1)
	arg_10_0._critterEffType = arg_10_1
end

function var_0_0.hideEffects(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0._effs) do
		gohelper.setActive(iter_11_1, false)
	end
end

function var_0_0.setCritterPos(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0._critterPos = arg_12_1
	arg_12_0._inDialog = arg_12_2

	arg_12_0:_refreshItem()
end

function var_0_0.getCritterPos(arg_13_0)
	return arg_13_0._critterPos
end

function var_0_0.setCritterEffectOffset(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0._effOffsetX = arg_14_1
	arg_14_0._effOffsetY = arg_14_2
end

function var_0_0.setCritterEffectScale(arg_15_0, arg_15_1)
	arg_15_0._scale = arg_15_1
end

local var_0_3 = {
	[true] = -160,
	[false] = -140
}
local var_0_4 = {
	-150,
	0,
	150
}
local var_0_5 = {
	2,
	1.5,
	2
}

function var_0_0._onSpineLoaded(arg_16_0)
	arg_16_0._spineGo = arg_16_0._roleSpine:getSpineGo()

	arg_16_0:_setSpine()
end

function var_0_0.playBodyAnim(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0._roleSpine:play(arg_17_1, arg_17_2)

	if arg_17_0._critterMo then
		local var_17_0 = arg_17_0._critterMo:getDefineId()
		local var_17_1 = CritterConfig.instance:getCritterInteractionAudioList(var_17_0, arg_17_1)

		if var_17_1 then
			for iter_17_0, iter_17_1 in ipairs(var_17_1) do
				AudioMgr.instance:trigger(iter_17_1)
			end
		end
	end
end

function var_0_0.fadeIn(arg_18_0)
	UIBlockMgr.instance:startBlock("fadeShow")
	arg_18_0:_clearTweens()
	arg_18_0:_fadeUpdate(0)

	arg_18_0._fadeInTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, arg_18_0._fadeUpdate, arg_18_0._fadeInFinished, arg_18_0, nil, EaseType.Linear)
end

function var_0_0._fadeUpdate(arg_19_0, arg_19_1)
	arg_19_0._canvasGroup.alpha = arg_19_1
end

function var_0_0._fadeInFinished(arg_20_0)
	UIBlockMgr.instance:endBlock("fadeShow")
end

function var_0_0.fadeOut(arg_21_0)
	UIBlockMgr.instance:startBlock("fadeShow")
	arg_21_0:_clearTweens()
	arg_21_0:_fadeUpdate(1)

	arg_21_0._fadeOutTweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 0.35, arg_21_0._fadeUpdate, arg_21_0._fadeOutFinished, arg_21_0, nil, EaseType.Linear)
end

function var_0_0._fadeOutFinished(arg_22_0)
	UIBlockMgr.instance:endBlock("fadeShow")
end

function var_0_0._clearTweens(arg_23_0)
	if arg_23_0._fadeInTweenId then
		ZProj.TweenHelper.KillById(arg_23_0._fadeInTweenId)

		arg_23_0._fadeInTweenId = nil
	end

	if arg_23_0._fadeOutTweenId then
		ZProj.TweenHelper.KillById(arg_23_0._fadeOutTweenId)

		arg_23_0._fadeOutTweenId = nil
	end
end

function var_0_0._setSpine(arg_24_0)
	local var_24_0 = var_0_4[arg_24_0._critterPos]
	local var_24_1 = var_0_3[arg_24_0._inDialog]
	local var_24_2 = var_0_5[arg_24_0._critterPos]
	local var_24_3 = arg_24_0._scale and arg_24_0._scale / var_24_2 or 1 / var_24_2

	transformhelper.setLocalPos(arg_24_0._spineGo.transform, var_24_0, var_24_1, 0)
	transformhelper.setLocalScale(arg_24_0._go.transform, var_24_2, var_24_2, 1)

	for iter_24_0, iter_24_1 in pairs(arg_24_0._effs) do
		transformhelper.setLocalScale(iter_24_1.transform, var_24_3, var_24_3, 1)
	end

	arg_24_0:showShadow(arg_24_0._critterPos == CritterEnum.PosType.Middle)
end

function var_0_0._refreshItem(arg_25_0)
	if arg_25_0._critterMo then
		if not arg_25_0._spineGo then
			local var_25_0 = CritterConfig.instance:getCritterSkinCfg(arg_25_0._critterMo:getSkinId())
			local var_25_1 = ResUrl.getSpineUIPrefab(var_25_0.spine)

			arg_25_0._roleSpine:setResPath(var_25_1, arg_25_0._onSpineLoaded, arg_25_0, true)
		else
			arg_25_0:_setSpine()
		end
	end

	arg_25_0:hideEffects()

	if not arg_25_0._critterEffType or arg_25_0._critterEffType == 0 then
		return
	end

	if arg_25_0._effs[arg_25_0._critterEffType] then
		gohelper.setActive(arg_25_0._effs[arg_25_0._critterEffType], true)
		transformhelper.setLocalPos(arg_25_0._effs[arg_25_0._critterEffType].transform, arg_25_0._effOffsetX or 0, arg_25_0._effOffsetY or 0, 0)
	else
		local var_25_2 = string.format("ui/viewres/story/%s.prefab", var_0_1[arg_25_0._critterEffType])

		arg_25_0._effLoader:addPath(var_25_2)
		arg_25_0._effLoader:startLoad(function()
			local var_26_0 = arg_25_0._effLoader:getAssetItem(var_25_2):GetResource(var_25_2)
			local var_26_1

			if arg_25_0._spineGo then
				var_26_1 = gohelper.findChild(arg_25_0._spineGo, "mountroot/mounthead")
			end

			local var_26_2 = gohelper.clone(var_26_0, var_26_1 or arg_25_0._go)

			arg_25_0._effs[arg_25_0._critterEffType] = var_26_2

			transformhelper.setLocalPos(var_26_2.transform, arg_25_0._effOffsetX or 0, arg_25_0._effOffsetY or 0, 0)
		end)
	end
end

function var_0_0.onDestroy(arg_27_0)
	arg_27_0:_clearTweens()

	if arg_27_0._effs then
		for iter_27_0, iter_27_1 in pairs(arg_27_0._effs) do
			gohelper.destroy(iter_27_1)
		end

		arg_27_0._effs = nil
	end

	if arg_27_0._effLoader then
		arg_27_0._effLoader:dispose()

		arg_27_0._effLoader = nil
	end

	if arg_27_0._tamingEffLoader then
		arg_27_0._tamingEffLoader:dispose()

		arg_27_0._tamingEffLoader = nil
	end

	if arg_27_0._shadowLoader then
		arg_27_0._shadowLoader:dispose()

		arg_27_0._shadowLoader = nil
	end

	AudioMgr.instance:trigger(AudioEnum.Room.stop_mi_bus)
end

return var_0_0
