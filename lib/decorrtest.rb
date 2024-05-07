class DecorrTestIF
    def pearsoCorrelation(x, y, a)
        raise NotImplementedError.new("#{self.class}##{__method__} が実装されていません")
    end
    def spearmanscorr(x, y, a)
        raise NotImplementedError.new("#{self.class}##{__method__} が実装されていません")
    end
    def kendallscorr(x, y, a)
        raise NotImplementedError.new("#{self.class}##{__method__} が実装されていません")
    end
end
class CorreFactIF
    def pearsoCorrelation(x, y, rth0, a)
        raise NotImplementedError.new("#{self.class}##{__method__} が実装されていません")
    end
    def spearmanscorr(x, y, rth0, a)
        raise NotImplementedError.new("#{self.class}##{__method__} が実装されていません")
    end
    def kendallscorr(x, y, rth0, a)
        raise NotImplementedError.new("#{self.class}##{__method__} が実装されていません")
    end
end
