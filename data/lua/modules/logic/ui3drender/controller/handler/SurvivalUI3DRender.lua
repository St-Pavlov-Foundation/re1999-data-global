-- chunkname: @modules/logic/ui3drender/controller/handler/SurvivalUI3DRender.lua

module("modules.logic.ui3drender.controller.handler.SurvivalUI3DRender", package.seeall)

local SurvivalUI3DRender = class("SurvivalUI3DRender", UserDataDispose)

function SurvivalUI3DRender:ctor(texW, texH, pos)
	self:__onInit()

	self.texW = texW
	self.texH = texH
	self.pos = pos
end

function SurvivalUI3DRender:init()
	self._rt = UnityEngine.RenderTexture.GetTemporary(self.texW, self.texH, 0, UnityEngine.RenderTextureFormat.ARGB32)
	self._modelList = {}
	self._hangeRoots = self:getUserDataTb_()
	self._loader = SequenceAbLoader.New()

	self._loader:addPath("survival/common/survivalcamera.prefab")
	self._loader:startLoad(self._onResLoad, self)
	self:initCamera()
end

function SurvivalUI3DRender:dispose()
	for _, item in pairs(self._modelList) do
		gohelper.destroy(item)
	end

	self._modelList = {}

	if self._rt then
		UnityEngine.RenderTexture.ReleaseTemporary(self._rt)

		self._rt = nil
	end

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	if self._cameraObj then
		gohelper.destroy(self._cameraObj)

		self._cameraObj = nil
	end

	self:__onDispose()
end

function SurvivalUI3DRender:getRenderTexture()
	return self._rt
end

function SurvivalUI3DRender:_onResLoad()
	local prefab = self._loader:getFirstAssetItem():GetResource()

	self._cameraObj = gohelper.clone(prefab)

	local trans = self._cameraObj.transform

	transformhelper.setLocalPos(trans, self.pos[1], self.pos[2], self.pos[3])

	local camera = self._cameraObj:GetComponentInChildren(typeof(UnityEngine.Camera))

	camera.targetTexture = self._rt

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Survival then
		camera.farClipPlane = 1
		camera.nearClipPlane = 0.05

		transformhelper.setLocalScale(trans, 0.16, 0.16, 0.16)
	end

	self:setHangRoot(trans)

	for hangPath, item in pairs(self._modelList) do
		if self._hangeRoots[hangPath] then
			item.transform:SetParent(self._hangeRoots[hangPath], false)
		end
	end
end

function SurvivalUI3DRender:setHangRoot(trans, preName)
	for i = 0, trans.childCount - 1 do
		local child = trans:GetChild(i)
		local path = child.name

		if preName then
			path = preName .. path
		end

		self._hangeRoots[path] = child

		self:setHangRoot(child, path .. "/")
	end
end

function SurvivalUI3DRender:addModel(hangPath, resPath)
	local go = self._modelList[hangPath] or UnityEngine.GameObject.New()
	local loader = PrefabInstantiate.Create(go)

	if loader:getPath() ~= resPath then
		if self._loaderEndCallBack and self._loaderEndCallBack[loader] then
			self._loaderEndCallBack[loader] = nil
		end

		if self._curAnims then
			self._curAnims[hangPath] = nil
		end

		loader:dispose()

		if not string.nilorempty(resPath) then
			loader:startLoad(resPath, self._onModelLoaded, self)
		end
	end

	self._modelList[hangPath] = go

	if self._hangeRoots[hangPath] then
		go.transform:SetParent(self._hangeRoots[hangPath], false)
	end

	return go
end

function SurvivalUI3DRender:playAnim(hangPath, animName)
	local go = self._modelList[hangPath]

	if not go then
		return
	end

	self._curAnims = self._curAnims or {}

	if self._curAnims[hangPath] == animName then
		return
	end

	self._curAnims[hangPath] = animName

	local loader = PrefabInstantiate.Create(go)
	local resGo = loader:getInstGO()

	if not resGo then
		table.insert(self:getEndCallback(loader), {
			self.playAnim,
			self,
			hangPath,
			animName
		})
	else
		local anim = gohelper.findChildAnim(resGo, "")

		if anim and anim.isActiveAndEnabled then
			anim:Play(animName, 0, 0)
		end
	end
end

function SurvivalUI3DRender:getEndCallback(loader)
	self._loaderEndCallBack = self._loaderEndCallBack or {}
	self._loaderEndCallBack[loader] = self._loaderEndCallBack[loader] or {}

	return self._loaderEndCallBack[loader]
end

function SurvivalUI3DRender:setModelPathActive(hangPath, path, isActive)
	local go = self._modelList[hangPath]

	if not go then
		return
	end

	local loader = PrefabInstantiate.Create(go)
	local resGo = loader:getInstGO()

	if not resGo then
		table.insert(self:getEndCallback(loader), {
			self.setModelPathActive,
			self,
			hangPath,
			path,
			isActive
		})
	else
		local go2 = gohelper.findChild(resGo, path)

		gohelper.setActive(go2, isActive)
	end
end

function SurvivalUI3DRender:_onModelLoaded(loader)
	local list = self._loaderEndCallBack and self._loaderEndCallBack[loader]

	if list then
		for _, v in ipairs(list) do
			v[1](v[2], unpack(v, 3))
		end

		self._loaderEndCallBack[loader] = nil
	end
end

function SurvivalUI3DRender:onDestroy()
	return
end

local allRolePath = {
	"node1/role",
	"node2/role",
	"node6/role"
}

function SurvivalUI3DRender:initCamera()
	local path = SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.PlayerRes)

	self._allResGo = self:getUserDataTb_()

	for i, v in ipairs(allRolePath) do
		self._allResGo[v] = self:addModel(v, path)
	end

	self:hideOtherModel()
end

function SurvivalUI3DRender:setSurvival3DModelMO(survival3DModelMO)
	self._curHeroPath = survival3DModelMO.curHeroPath
	self._curUnitPath = survival3DModelMO.curUnitPath
	self.unitPath = survival3DModelMO.unitPath

	if self._curUnitPath then
		self._allResGo[self._curUnitPath] = self:addModel(self._curUnitPath, self.unitPath)
	end

	if survival3DModelMO.isHandleHeroPath and self._curHeroPath then
		self:setModelPathActive(self._curHeroPath, "#go_effect", survival3DModelMO.isSearch)
		self:playAnim(self._curHeroPath, survival3DModelMO.isSearch and "search" or "idle")
	end

	self:hideOtherModel()
end

function SurvivalUI3DRender:hideOtherModel()
	for path, go in pairs(self._allResGo) do
		gohelper.setActive(go, path == self._curHeroPath or path == self._curUnitPath)
	end
end

local animTypeToName = {
	[0] = "idle",
	"jump",
	"jump2",
	"down_idle"
}

function SurvivalUI3DRender:playNextAnim(animType)
	if self._curHeroPath then
		if animTypeToName[animType] then
			self:playAnim(self._curHeroPath, animTypeToName[animType])
		else
			logError("未处理角色动作类型" .. tostring(animType))
		end
	end
end

return SurvivalUI3DRender
