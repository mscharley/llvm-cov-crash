use async_trait::async_trait;

#[async_trait]
pub trait Trait {
    async fn method(&self) -> bool;
}

pub struct Impl;

#[async_trait]
impl Trait for Impl {
    async fn method(&self) -> bool {
        if true { true } else { false }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[tokio::test]
    async fn test() {
        let g = Impl;
        let _ = g.method().await;
    }
}
