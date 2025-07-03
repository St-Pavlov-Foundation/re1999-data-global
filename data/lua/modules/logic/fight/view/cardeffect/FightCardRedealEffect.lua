module("modules.logic.fight.view.cardeffect.FightCardRedealEffect", package.seeall)

local var_0_0 = class("FightCardRedealEffect", BaseWork)
local var_0_1 = "UNITY_UI_DISSOLVE"
local var_0_2 = "ui/materials/dynamic/kapairongjie.mat"

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	if arg_1_0.context.oldCards and #arg_1_0.context.oldCards > 0 then
		arg_1_0._paramDict = {}
		arg_1_0._loadingDissolveMat = true

		loadAbAsset(var_0_2, false, arg_1_0._onLoadDissolveMat, arg_1_0)
		TaskDispatcher.runDelay(arg_1_0._delayDone, arg_1_0, 1.3 / FightModel.instance:getUISpeed())
	else
		logError("手牌变更失败，没有数据")
		TaskDispatcher.runDelay(arg_1_0._delayDone, arg_1_0, 0.5 / FightModel.instance:getUISpeed())
	end
end

function var_0_0._onLoadDissolveMat(arg_2_0, arg_2_1)
	arg_2_0._loadingDissolveMat = nil

	if arg_2_1.IsLoadSuccess then
		arg_2_0._dissolveMat = UnityEngine.GameObject.Instantiate(arg_2_1:GetResource())

		arg_2_0:_setupDissolveMat()
		arg_2_0:_playDissolveMat()
	end

	arg_2_0:_playEffects()
end

function var_0_0._playEffects(arg_3_0)
	arg_3_0._effectGOList = {}
	arg_3_0._effectLoaderList = {}

	local var_3_0 = arg_3_0.context.oldCards

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.context.oldCards) do
		if not arg_3_0.context.handCardItemList[iter_3_0].go.activeInHierarchy then
			arg_3_0:onDone(true)

			return
		end
	end

	for iter_3_2, iter_3_3 in ipairs(arg_3_0.context.oldCards) do
		local var_3_1 = arg_3_0.context.handCardItemList[iter_3_2]
		local var_3_2 = var_3_0[iter_3_2]
		local var_3_3 = FightCardDataHelper.getSkillLv(var_3_2.uid, var_3_2.skillId)
		local var_3_4 = gohelper.findChild(var_3_1.go, "changeEffect") or gohelper.create2d(var_3_1.go, "changeEffect")
		local var_3_5 = PrefabInstantiate.Create(var_3_4)

		arg_3_0._paramDict[var_3_5] = {
			oldCardLv = var_3_3
		}

		var_3_5:startLoad(FightPreloadOthersWork.ClothSkillEffectPath, arg_3_0._onClothSkillEffectLoaded, arg_3_0)
		table.insert(arg_3_0._effectGOList, var_3_4)
		table.insert(arg_3_0._effectLoaderList, var_3_5)
	end
end

function var_0_0._onClothSkillEffectLoaded(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._paramDict[arg_4_1].oldCardLv
	local var_4_1 = gohelper.findChild(arg_4_1:getInstGO(), tostring(var_4_0))

	gohelper.onceAddComponent(var_4_1, typeof(ZProj.EffectTimeScale)):SetTimeScale(FightModel.instance:getUISpeed())
	gohelper.setActive(var_4_1, true)
end

function var_0_0._setupDissolveMat(arg_5_0)
	arg_5_0._imgMaskMatDict = {}
	arg_5_0._imgMaskCloneDict = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.context.oldCards) do
		local var_5_0 = arg_5_0.context.handCardItemList[iter_5_0]
		local var_5_1 = gohelper.findChild(var_5_0.go, "foranim")
		local var_5_2 = {}

		var_0_0._getChildActiveImage(var_5_1, var_5_2)

		for iter_5_2, iter_5_3 in ipairs(var_5_2) do
			if iter_5_3.material == iter_5_3.defaultMaterial then
				arg_5_0._needSetMatNilDict = arg_5_0._needSetMatNilDict or {}
				arg_5_0._needSetMatNilDict[iter_5_3] = true
				iter_5_3.material = arg_5_0._dissolveMat
			else
				arg_5_0._imgMaskMatDict[iter_5_3] = iter_5_3.material
				iter_5_3.material = UnityEngine.GameObject.Instantiate(iter_5_3.material)

				iter_5_3.material:EnableKeyword(var_0_1)
				iter_5_3.material:SetVector("_OutSideColor", Vector4.New(0, 0, 0, 1))
				iter_5_3.material:SetVector("_InSideColor", Vector4.New(0, 0, 0, 1))

				arg_5_0._imgMaskCloneDict[iter_5_3] = iter_5_3.material
			end
		end
	end
end

function var_0_0._getChildActiveImage(arg_6_0, arg_6_1)
	if arg_6_0.activeInHierarchy and arg_6_0:GetComponent(typeof(UnityEngine.RectTransform)) then
		local var_6_0 = arg_6_0:GetComponent(gohelper.Type_Image)

		if var_6_0 then
			table.insert(arg_6_1, var_6_0)
		end

		local var_6_1 = arg_6_0.transform
		local var_6_2 = var_6_1.childCount

		for iter_6_0 = 0, var_6_2 - 1 do
			local var_6_3 = var_6_1:GetChild(iter_6_0)

			var_0_0._getChildActiveImage(var_6_3.gameObject, arg_6_1)
		end
	end
end

function var_0_0._playDissolveMat(arg_7_0)
	local var_7_0 = MaterialUtil.getPropValueFromMat(arg_7_0._dissolveMat, "_DissolveOffset", "Vector4")
	local var_7_1 = Vector4.New(0.07, var_7_0.y, var_7_0.z, var_7_0.w)

	MaterialUtil.setPropValue(arg_7_0._dissolveMat, "_DissolveOffset", "Vector4", var_7_1)

	arg_7_0._tweenId = ZProj.TweenHelper.DOTweenFloat(0.07, 1.7526, 0.6, function(arg_8_0)
		var_7_1.x = arg_8_0

		MaterialUtil.setPropValue(arg_7_0._dissolveMat, "_DissolveOffset", "Vector4", var_7_1)

		if arg_7_0._imgMaskCloneDict then
			for iter_8_0, iter_8_1 in pairs(arg_7_0._imgMaskCloneDict) do
				MaterialUtil.setPropValue(iter_8_1, "_DissolveOffset", "Vector4", var_7_1)
			end
		end
	end, function()
		if arg_7_0.context.newCards then
			for iter_9_0, iter_9_1 in ipairs(arg_7_0.context.newCards) do
				local var_9_0 = arg_7_0.context.handCardItemList[iter_9_0]

				if var_9_0 then
					var_9_0:updateItem(iter_9_0, iter_9_1)
				end
			end
		end

		arg_7_0._tweenId = ZProj.TweenHelper.DOTweenFloat(1.7526, 0.07, 0.6, function(arg_10_0)
			var_7_1.x = arg_10_0

			MaterialUtil.setPropValue(arg_7_0._dissolveMat, "_DissolveOffset", "Vector4", var_7_1)

			if arg_7_0._imgMaskCloneDict then
				for iter_10_0, iter_10_1 in pairs(arg_7_0._imgMaskCloneDict) do
					MaterialUtil.setPropValue(iter_10_1, "_DissolveOffset", "Vector4", var_7_1)
				end
			end
		end)
	end)
end

function var_0_0._delayDone(arg_11_0)
	if arg_11_0._lockGO then
		gohelper.setActive(arg_11_0._lockGO, true)

		arg_11_0._lockGO = nil
	end

	arg_11_0:onDone(true)
end

function var_0_0.clearWork(arg_12_0)
	if arg_12_0._loadingDissolveMat then
		removeAssetLoadCb(var_0_2, arg_12_0._onLoadDissolveMat, arg_12_0)
	end

	TaskDispatcher.cancelTask(arg_12_0._delayDone, arg_12_0)
	arg_12_0:_removeEffect()
	arg_12_0:_removeDissolveMat()

	if arg_12_0._tweenId then
		ZProj.TweenHelper.KillById(arg_12_0._tweenId)
	end

	if arg_12_0._dissolveMat then
		gohelper.destroy(arg_12_0._dissolveMat)
	end

	arg_12_0._imgMaskMatDict = nil
	arg_12_0._dissolveMat = nil
	arg_12_0._tweenId = nil
	arg_12_0._lockGO = nil
	arg_12_0._paramDict = nil
end

function var_0_0._removeDissolveMat(arg_13_0)
	if arg_13_0._imgMaskMatDict then
		for iter_13_0, iter_13_1 in pairs(arg_13_0._imgMaskMatDict) do
			iter_13_0.material = iter_13_1
			arg_13_0._imgMaskMatDict[iter_13_0] = nil
		end
	end

	if arg_13_0._imgMaskCloneDict then
		for iter_13_2, iter_13_3 in pairs(arg_13_0._imgMaskCloneDict) do
			gohelper.destroy(iter_13_3)

			arg_13_0._imgMaskCloneDict[iter_13_2] = nil
		end
	end

	if arg_13_0._needSetMatNilDict then
		for iter_13_4, iter_13_5 in pairs(arg_13_0._needSetMatNilDict) do
			iter_13_4.material = nil
			arg_13_0._needSetMatNilDict[iter_13_4] = nil
		end
	end

	arg_13_0._needSetMatNilDict = nil
	arg_13_0._imgMaskCloneDict = nil
	arg_13_0._imgMaskMatDict = nil
end

function var_0_0._removeEffect(arg_14_0)
	if arg_14_0._effectLoaderList then
		for iter_14_0, iter_14_1 in ipairs(arg_14_0._effectLoaderList) do
			iter_14_1:dispose()
		end
	end

	if arg_14_0._effectGOList then
		for iter_14_2, iter_14_3 in ipairs(arg_14_0._effectGOList) do
			gohelper.destroy(iter_14_3)
		end
	end

	arg_14_0._effectGOList = nil
	arg_14_0._effectLoaderList = nil
end

return var_0_0
