module("modules.logic.weather.eggs.SceneEggTv", package.seeall)

local var_0_0 = class("SceneEggTv", SceneBaseEgg)

function var_0_0._onEnable(arg_1_0)
	gohelper.setActive(arg_1_0._go, false)
	arg_1_0:_showIcon()
end

function var_0_0._onDisable(arg_2_0)
	if arg_2_0._srcLoader then
		arg_2_0._srcLoader:dispose()

		arg_2_0._srcLoader = nil
	end

	gohelper.setActive(arg_2_0._go, false)
	arg_2_0:_openAnim(false)
end

function var_0_0._openAnim(arg_3_0, arg_3_1)
	if arg_3_1 then
		gohelper.setActive(arg_3_0._goWhite, true)

		if arg_3_0._whiteAnimator and arg_3_0._whiteAnimator.isActiveAndEnabled then
			arg_3_0._whiteAnimator:Play("open", arg_3_0._onAnimDone, arg_3_0)
		else
			gohelper.setActive(arg_3_0._goWhite, false)
		end
	elseif arg_3_0._isOpenAnim then
		gohelper.setActive(arg_3_0._goWhite, true)

		if arg_3_0._whiteAnimator and arg_3_0._whiteAnimator.isActiveAndEnabled then
			arg_3_0._whiteAnimator:Play("close", arg_3_0._onAnimDone, arg_3_0)
		else
			gohelper.setActive(arg_3_0._goWhite, false)
		end
	else
		gohelper.setActive(arg_3_0._goWhite, false)
	end

	arg_3_0._isOpenAnim = arg_3_1
end

function var_0_0._onAnimDone(arg_4_0)
	gohelper.setActive(arg_4_0._goWhite, false)
end

function var_0_0._onInit(arg_5_0)
	arg_5_0._go = arg_5_0._goList[1]
	arg_5_0._goWhite = arg_5_0._goList[2]
	arg_5_0._whiteAnimator = SLFramework.AnimatorPlayer.Get(arg_5_0._goWhite)

	if not arg_5_0._whiteAnimator then
		logError("SceneEggTv white animator is null")
	end

	gohelper.setActive(arg_5_0._goWhite, false)
	gohelper.setActive(arg_5_0._go, false)

	arg_5_0._iconIndex = 1

	arg_5_0:_initIconId()

	local var_5_0 = arg_5_0._go:GetComponent(typeof(UnityEngine.MeshRenderer))

	arg_5_0._mat = UnityEngine.Object.Instantiate(var_5_0.sharedMaterial)
	var_5_0.material = arg_5_0._mat
end

function var_0_0._initIconId(arg_6_0)
	arg_6_0._iconList = {
		0
	}

	for iter_6_0, iter_6_1 in ipairs(lua_loading_icon.configList) do
		table.insert(arg_6_0._iconList, iter_6_1.id)
	end
end

function var_0_0._showIcon(arg_7_0)
	if arg_7_0._srcLoader then
		arg_7_0._srcLoader:dispose()

		arg_7_0._srcLoader = nil
	end

	local var_7_0 = arg_7_0:_getRandomIcon()

	arg_7_0._iconUrl = var_7_0
	arg_7_0._srcLoader = MultiAbLoader.New()

	arg_7_0._srcLoader:addPath(var_7_0)
	arg_7_0._srcLoader:startLoad(arg_7_0._onLoadIconComplete, arg_7_0)
end

function var_0_0._onLoadIconComplete(arg_8_0)
	local var_8_0 = arg_8_0._srcLoader:getFirstAssetItem()

	if var_8_0 then
		arg_8_0._mat.mainTexture = var_8_0:GetResource(arg_8_0._iconUrl)

		gohelper.setActive(arg_8_0._go, true)
		arg_8_0:_openAnim(true)
	end
end

function var_0_0._getRandomIcon(arg_9_0)
	local var_9_0 = arg_9_0:_getRandomIndex()
	local var_9_1 = arg_9_0._iconList[var_9_0]

	if var_9_1 > 0 then
		local var_9_2 = lua_loading_icon.configDict[var_9_1]

		if var_9_2 then
			return ResUrl.getLoadingBg(var_9_2.pic)
		end
	end

	return "scenes/dynamic/v2a5_m_s01_zjm_a/lightmaps/dianshiji.png"
end

function var_0_0._getRandomIndex(arg_10_0)
	local var_10_0 = math.random(1, #arg_10_0._iconList)

	if var_10_0 ~= arg_10_0._iconIndex then
		arg_10_0._iconIndex = var_10_0

		return var_10_0
	end

	arg_10_0._iconIndex = arg_10_0._iconIndex + 1

	if arg_10_0._iconIndex > #arg_10_0._iconList then
		arg_10_0._iconIndex = 1
	end

	return arg_10_0._iconIndex
end

function var_0_0._onSceneClose(arg_11_0)
	if arg_11_0._srcLoader then
		arg_11_0._srcLoader:dispose()

		arg_11_0._srcLoader = nil
	end
end

return var_0_0
