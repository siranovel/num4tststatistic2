require 'num4tststatistic'
require 'hypothTest3'

# 相関検定
module Num4CorrTestLib
    # 無相関の検定
    class DecorrTestLib
        def initialize
            @corr = CorrStatisticLib.new
            @hypothTest = Num4HypothTestLib::DecorrTestLib.new
        end
        # ピアソン相関係数
        #
        # @overload pearsoCorrelation(x, y, a)
        #   @param [Array] x xのデータ(double[])
        #   @param [Array] y yのデータ(double[])
        #   @param  [double] a  有意水準
        #   @return [boolean] 検定結果(true:棄却域内 false:棄却域外)
        # @example
        #   x = [113, 64, 16, 45, 28, 19, 30, 82, 76]
        #   y = [31, 5, 2, 17, 18, 2, 9, 25, 13]
        #   corrTest = CorrTestLib::DecorrTestLib.new
        #   corrTest.pearsoCorrelation(x, y, 0.05)
        #   => true
        def pearsoCorrelation(x, y, a)
            df = x.size - 2
            statistic = @corr.pearsoCorrelation(x, y)
            return @hypothTest.twoSideTest(statistic, df, a)
        end
        # スピアマンの順位相関係数
        #
        # @overload spearmanscorr(x, y, a)
        #   @param [Array] x xのデータ(double[])
        #   @param [Array] y yのデータ(double[])
        #   @param  [double] a  有意水準
        #   @return [boolean] 検定結果(true:棄却域内 false:棄却域外)
        # @example
        #   x = [113, 64, 16, 45, 28, 19, 30, 82, 76]
        #   y = [31, 5, 2, 17, 18, 2, 9, 25, 13]
        #   corrTest = CorrTestLib::DecorrTestLib.new
        #   corrTest.spearmanscorr(x, y, 0.05)
        #   => true
        def spearmanscorr(x, y, a)
            df = x.size - 2
            statistic = @corr.spearmanscorr(x, y)
            return @hypothTest.twoSideTest(statistic, df, a)
        end
        # ケンドールの順位相関係数
        #
        # @overload kendallscorr(x, y, a)
        #   @param [Array] x xのデータ(double[])
        #   @param [Array] y yのデータ(double[])
        #   @param  [double] a  有意水準
        #   @return [boolean] 検定結果(true:棄却域内 false:棄却域外)
        # @example
        #   x = [113, 64, 16, 45, 28, 19, 30, 82, 76]
        #   y = [31, 5, 2, 17, 18, 2, 9, 25, 13]
        #   corrTest = CorrTestLib::DecorrTestLib.new
        #   corrTest.kendallscorr(x, y, 0.05)
        #   => false
        def kendallscorr(x, y, a)
            df = x.size - 2
            statistic = @corr.kendallscorr(x, y)
            return @hypothTest.twoSideTest(statistic, df, a)
        end
    end
    # 母相関係数の検定
    class CorreFactLib
        def initialize(hypothTest3)
            @hypothTest3 = hypothTest3
            @corr = CorrStatisticLib.new
        end
        # ピアソン相関係数
        #
        # @overload pearsoCorrelation(x, y, rth0, a)
        #   @param [Array] x xのデータ(double[])
        #   @param [Array] y yのデータ(double[])
        #   @param [double] rth0 母相関係数
        #   @param  [double] a  有意水準
        #   @return [boolean] 検定結果(true:棄却域内 false:棄却域外)
        # @example
        #   x = [113, 64, 16, 45, 28, 19, 30, 82, 76]
        #   y = [31, 5, 2, 17, 18, 2, 9, 25, 13]
        #   hypothTest = Num4HypothTestLib::TwoSideTestLib.new
        #   corrTest = CorrTestLib::CorreFactLib.new(hypothTest)
        #   corrTest.pearsoCorrelation(x, y,  -0.3, 0.05)
        #   => true
        def pearsoCorrelation(x, y, rth0, a)
            raise TypeError unless @hypothTest3.kind_of?(HypothTest3IF)
            statistic = @corr.pearsoCorrelation(x, y)
            return @hypothTest3.populationCorre(statistic, x.size, rth0, a)
        end
        # スピアマンの順位相関係数
        #
        # @overload spearmanscorr(x, y, rth0, a)
        #   @param [Array] x xのデータ(double[])
        #   @param [Array] y yのデータ(double[])
        #   @param [double] rth0 母相関係数
        #   @param  [double] a  有意水準
        #   @return [boolean] 検定結果(true:棄却域内 false:棄却域外)
        # @example
        #   x = [113, 64, 16, 45, 28, 19, 30, 82, 76]
        #   y = [31, 5, 2, 17, 18, 2, 9, 25, 13]
        #   hypothTest = Num4HypothTestLib::TwoSideTestLib.new
        #   corrTest = CorrTestLib::CorreFactLib.new(hypothTest)
        #   corrTest.spearmanscorr(x, y, -0.3, 0.05)
        #   => true
        def spearmanscorr(x, y, rth0, a)
            raise TypeError unless @hypothTest3.kind_of?(HypothTest3IF)
            statistic = @corr.spearmanscorr(x, y)
            return @hypothTest3.populationCorre(statistic, x.size, rth0, a)
        end
        # ケンドールの順位相関係数
        #
        # @overload kendallscorr(x, y, rth0, a)
        #   @param [Array] x xのデータ(double[])
        #   @param [Array] y yのデータ(double[])
        #   @param [double] rth0 母相関係数
        #   @param  [double] a  有意水準
        #   @return [boolean] 検定結果(true:棄却域内 false:棄却域外)
        # @example
        #   x = [113, 64, 16, 45, 28, 19, 30, 82, 76]
        #   y = [31, 5, 2, 17, 18, 2, 9, 25, 13]
        #   hypothTest = Num4HypothTestLib::TwoSideTestLib.new
        #   corrTest = CorrTestLib::CorreFactLib.new(hypothTest)
        #   corrTest.kendallscorr(x, y, -0.3, 0.05)
        #   => true
        def kendallscorr(x, y, rth0, a)
            raise TypeError unless @hypothTest3.kind_of?(HypothTest3IF)
            statistic = @corr.kendallscorr(x, y)
            return @hypothTest3.populationCorre(statistic, x.size, rth0, a)
        end
    end
    # 差の母相関係数の検定
    class DiffCorreFactLib
        def initialize(hypothTest3)
            @hypothTest3 = hypothTest3
            @corr = CorrStatisticLib.new
        end
        # ピアソン相関係数
        #
        # @overload pearsoCorrelation(xy1, xy2, a)
        #   @param [Array] xy1 xy1のデータ(double[][])
        #   @param [Array] xy2 xy2のデータ(double[][])
        #   @param  [double] a  有意水準
        #   @return [boolean] 検定結果(true:棄却域内 false:棄却域外)
        # @example
        #   xy1 = [
        #           [113, 64, 16, 45, 28, 19, 30, 82, 76],
        #           [31, 5, 2, 17, 18, 2, 9, 25, 13]
        #         ]
        #   xy2 = [
        #           [113, 64, 16, 45, 28, 19, 30, 82, 76],
        #           [31, 5, 2, 17, 18, 2, 9, 25, 13]
        #         ]
        #   hypothTest = Num4HypothTestLib::TwoSideTestLib.new
        #   corrTest = CorrTestLib::DiffCorreFactLib.new(hypothTest)
        #   corrTest.pearsoCorrelation(xy1, xy2, 0.05)
        #   => false
        def pearsoCorrelation(xy1, xy2, a)
            raise TypeError unless @hypothTest3.kind_of?(HypothTest3IF)
            statistic1 = @corr.pearsoCorrelation(xy1[0], xy1[1])
            statistic2 = @corr.pearsoCorrelation(xy2[0], xy2[1])
            return @hypothTest3.diffPopulationCorre(statistic1, xy1[0].size, statistic2, xy2[0].size, a)
        end
        # スピアマンの順位相関係数
        #
        # @overload spearmanscorr(xy1, xy2, a)
        #   @param [Array] xy1 xy1のデータ(double[][])
        #   @param [Array] xy2 xy2のデータ(double[][])
        #   @param  [double] a  有意水準
        #   @return [boolean] 検定結果(true:棄却域内 false:棄却域外)
        # @example
        #   xy1 = [
        #           [113, 64, 16, 45, 28, 19, 30, 82, 76],
        #           [31, 5, 2, 17, 18, 2, 9, 25, 13]
        #         ]
        #   xy2 = [
        #           [113, 64, 16, 45, 28, 19, 30, 82, 76],
        #           [31, 5, 2, 17, 18, 2, 9, 25, 13]
        #         ]
        #   hypothTest = Num4HypothTestLib::TwoSideTestLib.new
        #   corrTest = CorrTestLib::DiffCorreFactLib.new(hypothTest)
        #   corrTest.spearmanscorr(xy1, xy2, 0.05)
        #   => false
        def spearmanscorr(xy1, xy2, a)
            raise TypeError unless @hypothTest3.kind_of?(HypothTest3IF)
            statistic1 = @corr.spearmanscorr(xy1[0], xy1[1])
            statistic2 = @corr.spearmanscorr(xy2[0], xy2[1])
            return @hypothTest3.diffPopulationCorre(statistic1, xy1[0].size, statistic2, xy2[0].size, a)
        end
        # ケンドールの順位相関係数
        #
        # @overload kendallscorr(xy1, xy2, a)
        #   @param [Array] xy1 xy1のデータ(double[][])
        #   @param [Array] xy2 xy2のデータ(double[][])
        #   @param  [double] a  有意水準
        #   @return [boolean] 検定結果(true:棄却域内 false:棄却域外)
        # @example
        #   xy1 = [
        #           [113, 64, 16, 45, 28, 19, 30, 82, 76],
        #           [31, 5, 2, 17, 18, 2, 9, 25, 13]
        #         ]
        #   xy2 = [
        #           [113, 64, 16, 45, 28, 19, 30, 82, 76],
        #           [31, 5, 2, 17, 18, 2, 9, 25, 13]
        #         ]
        #   hypothTest = Num4HypothTestLib::TwoSideTestLib.new
        #   corrTest = CorrTestLib::DiffCorreFactLib.new(hypothTest)
        #   corrTest.kendallscorr(xy1, xy2, 0.05)
        #   => false
        def kendallscorr(xy1, xy2, a)
            raise TypeError unless @hypothTest3.kind_of?(HypothTest3IF)
            statistic1 = @corr.kendallscorr(xy1[0], xy1[1])
            statistic2 = @corr.kendallscorr(xy2[0], xy2[1])
            return @hypothTest3.diffPopulationCorre(statistic1, xy1[0].size, statistic2, xy2[0].size, a)
        end
    end
    # 相関係数を計算
    class CorrStatisticLib
        def initialize
            @paraTest = Num4TstStatisticLib::ParametrixTestLib.new
            @nonParaTest = Num4TstStatisticLib::NonParametrixTestLib.new
        end
        def pearsoCorrelation(x, y)
            return @paraTest.pearsoCorrelation(x, y)
        end
        def spearmanscorr(x, y)
            return @nonParaTest.spearmanscorr(x, y)
        end
        def kendallscorr(x, y)
            return  @nonParaTest.kendallscorr(x, y)
        end
    end
    private_constant :CorrStatisticLib
end
