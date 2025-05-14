module("modules.common.preload.ShaderCache", package.seeall)

local var_0_0 = class("ShaderCache")

function var_0_0.ctor(arg_1_0)
	arg_1_0._resPath = "shaders"
	arg_1_0._shaderVCs = {}
	arg_1_0._hasWarmup = false
	arg_1_0._curIdx = 1
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._initCb = arg_2_1
	arg_2_0._initCbObj = arg_2_2

	if GameResMgr.IsFromEditorDir then
		arg_2_0:_triggerFinishCb()

		return
	end

	loadAbAsset(arg_2_0._resPath, false, arg_2_0._onLoadOne, arg_2_0)

	if isDebugBuild then
		SLFramework.TimeWatch.Instance:Start()
	end
end

function var_0_0._onLoadOne(arg_3_0, arg_3_1)
	if isDebugBuild then
		logNormal("ShaderCache 加载AB耗时:" .. SLFramework.TimeWatch.Instance:Watch() .. " s!")
		SLFramework.TimeWatch.Instance:Start()
	end

	if arg_3_1.IsLoadSuccess then
		arg_3_1:Retain()

		local var_3_0 = arg_3_1:GetAllResources()

		if isDebugBuild then
			logNormal("ShaderCache 加载shader及变体耗时:" .. SLFramework.TimeWatch.Instance:Watch() .. " s!")
		end

		for iter_3_0 = 0, var_3_0.Length - 1 do
			local var_3_1 = var_3_0[iter_3_0]

			if typeof(UnityEngine.ShaderVariantCollection) == var_3_1:GetType() then
				table.insert(arg_3_0._shaderVCs, var_3_1)
			else
				ZProj.ShaderLib.Add(var_3_1)
			end
		end

		if HotUpdateMgr.instance.shouldHotUpdate then
			arg_3_0:_warmupShaders()
		else
			arg_3_0:_triggerFinishCb()

			if isDebugBuild then
				logNormal("ShaderCache 无热更新，跳过shader变体预热")
			end
		end

		return
	end

	logError("ShaderCache shader加载失败！")
end

function var_0_0._warmupShaders(arg_4_0)
	if arg_4_0._hasWarmup then
		return
	end

	arg_4_0:_warmupOneShader()
end

function var_0_0._warmupOneShader(arg_5_0)
	if isDebugBuild then
		SLFramework.TimeWatch.Instance:Start()
	end

	local var_5_0 = arg_5_0._shaderVCs[arg_5_0._curIdx]

	var_5_0:WarmUp()
	BootLoadingView.instance:show(0.2 + arg_5_0._curIdx / #arg_5_0._shaderVCs * 0.4, booterLang("loading_res"))

	if isDebugBuild then
		logNormal("ShaderCache shader变体: " .. var_5_0.name .. " 预热耗时:" .. SLFramework.TimeWatch.Instance:Watch() .. " s!")
	end

	arg_5_0._curIdx = arg_5_0._curIdx + 1

	if arg_5_0._curIdx <= #arg_5_0._shaderVCs then
		TaskDispatcher.runDelay(arg_5_0._warmupOneShader, arg_5_0, 0.01)
	else
		arg_5_0._hasWarmup = true

		arg_5_0:_triggerFinishCb()
	end
end

function var_0_0._triggerFinishCb(arg_6_0)
	if arg_6_0._initCb then
		arg_6_0._initCb(arg_6_0._initCbObj)

		arg_6_0._initCb = nil
		arg_6_0._initCbObj = nil
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
