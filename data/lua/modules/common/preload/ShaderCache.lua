module("modules.common.preload.ShaderCache", package.seeall)

slot0 = class("ShaderCache")

function slot0.ctor(slot0)
	slot0._resPath = "shaders"
	slot0._shaderVCs = {}
	slot0._hasWarmup = false
	slot0._curIdx = 1
end

function slot0.init(slot0, slot1, slot2)
	slot0._initCb = slot1
	slot0._initCbObj = slot2

	if GameResMgr.IsFromEditorDir then
		slot0:_triggerFinishCb()

		return
	end

	loadAbAsset(slot0._resPath, false, slot0._onLoadOne, slot0)

	if isDebugBuild then
		SLFramework.TimeWatch.Instance:Start()
	end
end

function slot0._onLoadOne(slot0, slot1)
	if isDebugBuild then
		logNormal("ShaderCache 加载AB耗时:" .. SLFramework.TimeWatch.Instance:Watch() .. " s!")
		SLFramework.TimeWatch.Instance:Start()
	end

	if slot1.IsLoadSuccess then
		slot1:Retain()

		slot2 = slot1:GetAllResources()

		if isDebugBuild then
			logNormal("ShaderCache 加载shader及变体耗时:" .. SLFramework.TimeWatch.Instance:Watch() .. " s!")
		end

		for slot6 = 0, slot2.Length - 1 do
			if typeof(UnityEngine.ShaderVariantCollection) == slot2[slot6]:GetType() then
				table.insert(slot0._shaderVCs, slot7)
			else
				ZProj.ShaderLib.Add(slot7)
			end
		end

		if HotUpdateMgr.instance.shouldHotUpdate then
			slot0:_warmupShaders()
		else
			slot0:_triggerFinishCb()

			if isDebugBuild then
				logNormal("ShaderCache 无热更新，跳过shader变体预热")
			end
		end

		return
	end

	logError("ShaderCache shader加载失败！")
end

function slot0._warmupShaders(slot0)
	if slot0._hasWarmup then
		return
	end

	slot0:_warmupOneShader()
end

function slot0._warmupOneShader(slot0)
	if isDebugBuild then
		SLFramework.TimeWatch.Instance:Start()
	end

	slot0._shaderVCs[slot0._curIdx]:WarmUp()
	BootLoadingView.instance:show(0.2 + slot0._curIdx / #slot0._shaderVCs * 0.4, booterLang("loading_res"))

	if isDebugBuild then
		logNormal("ShaderCache shader变体: " .. slot1.name .. " 预热耗时:" .. SLFramework.TimeWatch.Instance:Watch() .. " s!")
	end

	slot0._curIdx = slot0._curIdx + 1

	if slot0._curIdx <= #slot0._shaderVCs then
		TaskDispatcher.runDelay(slot0._warmupOneShader, slot0, 0.01)
	else
		slot0._hasWarmup = true

		slot0:_triggerFinishCb()
	end
end

function slot0._triggerFinishCb(slot0)
	if slot0._initCb then
		slot0._initCb(slot0._initCbObj)

		slot0._initCb = nil
		slot0._initCbObj = nil
	end
end

slot0.instance = slot0.New()

return slot0
