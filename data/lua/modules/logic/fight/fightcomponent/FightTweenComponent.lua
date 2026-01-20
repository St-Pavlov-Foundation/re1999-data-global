-- chunkname: @modules/logic/fight/fightcomponent/FightTweenComponent.lua

module("modules.logic.fight.fightcomponent.FightTweenComponent", package.seeall)

local FightTweenComponent = class("FightTweenComponent", FightBaseClass)

function FightTweenComponent:onConstructor()
	self.TweenHelper = ZProj.TweenHelper
	self.index = 0
	self.tweenList = {}
end

function FightTweenComponent:DOTweenFloat(from, to, duration, frameCallback, finishCallback, handle, param, ease)
	ease = EaseType.Str2Type(ease)

	local tweenId = self.TweenHelper.DOTweenFloat(from, to, duration, frameCallback, finishCallback, handle, param, ease)

	self.index = self.index + 1
	self.tweenList[self.index] = tweenId
end

function FightTweenComponent:DOAnchorPos(tr, x, y, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)

	local tweenId = self.TweenHelper.DOAnchorPos(tr, x, y, duration, callback, handle, param, ease)

	self.index = self.index + 1
	self.tweenList[self.index] = tweenId
end

function FightTweenComponent:DOAnchorPosX(tr, x, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)

	local tweenId = self.TweenHelper.DOAnchorPosX(tr, x, duration, callback, handle, param, ease)

	self.index = self.index + 1
	self.tweenList[self.index] = tweenId
end

function FightTweenComponent:DOAnchorPosY(tr, y, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)

	local tweenId = self.TweenHelper.DOAnchorPosY(tr, y, duration, callback, handle, param, ease)

	self.index = self.index + 1
	self.tweenList[self.index] = tweenId
end

function FightTweenComponent:DOWidth(tr, endWidth, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)

	local tweenId = self.TweenHelper.DOWidth(tr, endWidth, duration, callback, handle, param, ease)

	self.index = self.index + 1
	self.tweenList[self.index] = tweenId
end

function FightTweenComponent:DOHeight(tr, endHeight, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)

	local tweenId = self.TweenHelper.DOHeight(tr, endHeight, duration, callback, handle, param, ease)

	self.index = self.index + 1
	self.tweenList[self.index] = tweenId
end

function FightTweenComponent:DOSizeDelta(tr, endWidth, endHeight, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)

	local tweenId = self.TweenHelper.DOSizeDelta(tr, endWidth, endHeight, duration, callback, handle, param, ease)

	self.index = self.index + 1
	self.tweenList[self.index] = tweenId
end

function FightTweenComponent:DOMove(tr, x, y, z, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)

	local tweenId = self.TweenHelper.DOMove(tr, x, y, z, duration, callback, handle, param, ease)

	self.index = self.index + 1
	self.tweenList[self.index] = tweenId
end

function FightTweenComponent:DOMoveX(tr, x, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)

	local tweenId = self.TweenHelper.DOMoveX(tr, x, duration, callback, handle, param, ease)

	self.index = self.index + 1
	self.tweenList[self.index] = tweenId
end

function FightTweenComponent:DOMoveY(tr, y, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)

	local tweenId = self.TweenHelper.DOMoveY(tr, y, duration, callback, handle, param, ease)

	self.index = self.index + 1
	self.tweenList[self.index] = tweenId
end

function FightTweenComponent:DOLocalMove(tr, x, y, z, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)

	local tweenId = self.TweenHelper.DOLocalMove(tr, x, y, z, duration, callback, handle, param, ease)

	self.index = self.index + 1
	self.tweenList[self.index] = tweenId
end

function FightTweenComponent:DOLocalMoveX(tr, x, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)

	local tweenId = self.TweenHelper.DOLocalMoveX(tr, x, duration, callback, handle, param, ease)

	self.index = self.index + 1
	self.tweenList[self.index] = tweenId
end

function FightTweenComponent:DOLocalMoveY(tr, y, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)

	local tweenId = self.TweenHelper.DOLocalMoveY(tr, y, duration, callback, handle, param, ease)

	self.index = self.index + 1
	self.tweenList[self.index] = tweenId
end

function FightTweenComponent:DOScale(tr, x, y, z, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)

	local tweenId = self.TweenHelper.DOScale(tr, x, y, z, duration, callback, handle, param, ease)

	self.index = self.index + 1
	self.tweenList[self.index] = tweenId
end

function FightTweenComponent:DORotate(tr, x, y, z, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)

	local tweenId = self.TweenHelper.DORotate(tr, x, y, z, duration, callback, handle, param, ease)

	self.index = self.index + 1
	self.tweenList[self.index] = tweenId
end

function FightTweenComponent:DOLocalRotate(tr, x, y, z, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)

	local tweenId = self.TweenHelper.DOLocalRotate(tr, x, y, z, duration, callback, handle, param, ease)

	self.index = self.index + 1
	self.tweenList[self.index] = tweenId
end

function FightTweenComponent:DoFade(graphic, start, final, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)

	local tweenId = self.TweenHelper.DoFade(graphic, start, final, duration, callback, handle, param, ease)

	self.index = self.index + 1
	self.tweenList[self.index] = tweenId
end

function FightTweenComponent:DOColor(graphic, endColor, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)

	local tweenId = self.TweenHelper.DOColor(graphic, endColor, duration, callback, handle, param, ease)

	self.index = self.index + 1
	self.tweenList[self.index] = tweenId
end

function FightTweenComponent:DOText(text, content, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)

	local tweenId = self.TweenHelper.DOText(text, content, duration, callback, handle, param, ease)

	self.index = self.index + 1
	self.tweenList[self.index] = tweenId
end

function FightTweenComponent:DOFadeCanvasGroup(obj, start, final, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)

	local tweenId = self.TweenHelper.DOFadeCanvasGroup(obj, start, final, duration, callback, handle, param, ease)

	self.index = self.index + 1
	self.tweenList[self.index] = tweenId
end

function FightTweenComponent:DOFillAmount(img, final, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)

	local tweenId = self.TweenHelper.DOFillAmount(img, final, duration, callback, handle, param, ease)

	self.index = self.index + 1
	self.tweenList[self.index] = tweenId
end

function FightTweenComponent:scrollNumTween(text, start, final, duration, ease)
	ease = EaseType.Str2Type(ease)

	local instanceId = text:GetInstanceID()

	if not self.scrollNumtweenList then
		self.scrollNumtweenList = {}
	end

	self:killTween(self.scrollNumtweenList[instanceId])

	local tweenId = self:DOTweenFloat(start, final, duration, self.onScrollNumFrame, nil, self, text, ease)

	self.scrollNumtweenList[instanceId] = tweenId

	return tweenId
end

function FightTweenComponent:onScrollNumFrame(value, text)
	text.text = math.ceil(value)
end

function FightTweenComponent:killTween(tweenId)
	if not tweenId then
		return
	end

	return self.TweenHelper.KillById(tweenId)
end

function FightTweenComponent:KillTweenByObj(obj, complete)
	return self.TweenHelper.KillByObj(obj, complete)
end

function FightTweenComponent:onDestructor()
	for i = 1, self.index do
		self.TweenHelper.KillById(self.tweenList[i])
	end
end

return FightTweenComponent
