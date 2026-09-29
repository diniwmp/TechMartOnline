package lk.tmart.ejb;

import lk.tmart.core.dto.CartItemDTO;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertTrue;

class CartItemDTOPerformanceTest {

    @Test
    void subtotalCalculation_completesWithinTimeLimit() {
        long start = System.nanoTime();

        for (int i = 0; i < 100_000; i++) {
            CartItemDTO dto = new CartItemDTO(1, 1, 1, "Test Product", "img.jpg", 1500.0, "BrandX", 3, 10);
            dto.getSubtotal();
        }

        long durationMs = (System.nanoTime() - start) / 1_000_000;
        System.out.println("100,000 subtotal calculations took " + durationMs + " ms");

        assertTrue(durationMs < 500, "Subtotal calculation should complete well under 500ms for 100k iterations");
    }
}